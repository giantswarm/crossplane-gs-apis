package main

import (
	"fmt"

	"crossbuilder/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.RdsBaseDbClusterGroupVersionKind,
		Object:           &v1alpha1.RdsBaseDbCluster{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("rds-base").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "database",
			"type":      "base",
		})

	var (
		resources                []xpt.ComposedTemplate = createResources()
		kclCreateClusterTemplate string
		kclResourcesTemplate     string
		err                      error
	)

	kclResourcesTemplate, err = build.LoadTemplate("compositions/rds-base/templates/resources.k")
	if err != nil {
		panic(err)
	}

	kclCreateClusterTemplate, err = build.LoadTemplate("compositions/rds-base/templates/create-cluster.k")
	if err != nil {
		panic(err)
	}

	c.NewPipelineStep("patch-and-transform").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-patch-and-transform",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xpt.Resources{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "pt.crossplane.io/v1beta1",
					Kind:       "Resources",
				},
				PatchSets: []xpt.PatchSet{
					metadataPatchSet(),
					commonPatchSet(),
				},
				Resources: resources,
			},
		})

	c.NewPipelineStep("function-kcl-create-cluster").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-kcl",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xkcl.KCLInput{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "krm.kcl.dev/v1alpha1",
					Kind:       "KCLInput",
				},
				Spec: xkcl.RunSpec{
					Source: kclCreateClusterTemplate,
				},
			},
		})

	c.NewPipelineStep("function-kcl-create-resources").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-kcl",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xkcl.KCLInput{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "krm.kcl.dev/v1alpha1",
					Kind:       "KCLInput",
				},
				Spec: xkcl.RunSpec{
					Source: kclResourcesTemplate,
				},
			},
		})

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}

func createResources() []xpt.ComposedTemplate {
	return []xpt.ComposedTemplate{
		createKmsResource(),
		createSubnetGroup(),
		createSecurityGroup(),
	}
}

func combineNameRegionPatch(toFieldPath, suffix string) xpt.ComposedPatch {
	return xpt.ComposedPatch{
		Type: xpt.PatchTypeCombineFromComposite,
		Patch: xpt.Patch{
			Combine: &xpt.Combine{
				Variables: []xpt.CombineVariable{
					{
						FromFieldPath: "spec.claimRef.name",
					},
					{
						FromFieldPath: "spec.region",
					},
				},
				Strategy: xpt.CombineStrategyString,
				String: &xpt.StringCombine{
					Format: fmt.Sprintf("%%s-%%s%s", suffix),
				},
			},
			ToFieldPath: cb.StrPtr(toFieldPath),
		},
	}
}
