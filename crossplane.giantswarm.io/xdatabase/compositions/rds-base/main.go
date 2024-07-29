package main

import (
	"fmt"
	"strings"

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
		GroupVersionKind: v1alpha1.RdsBaseGroupVersionKind,
		Object:           &v1alpha1.RdsBase{},
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
		kclCommon                string
		kclCreateClusterTemplate string
		kclResourcesTemplate     string
		kclSqlTemplate           string
		kclEsoTemplate           string
		kclPatchTemplate         string
		err                      error
	)

	kclCommon, err = build.LoadTemplate("compositions/rds-base/templates/common.k")
	if err != nil {
		panic(err)
	}

	kclResourcesTemplate, err = build.LoadTemplate("compositions/rds-base/templates/resources.k")
	if err != nil {
		panic(err)
	}

	kclCreateClusterTemplate, err = build.LoadTemplate("compositions/rds-base/templates/create-cluster.k")
	if err != nil {
		panic(err)
	}

	kclPatchTemplate, err = build.LoadTemplate("compositions/rds-base/templates/patching.k")
	if err != nil {
		panic(err)
	}

	kclSqlTemplate, err = build.LoadTemplate("compositions/rds-base/templates/provision-sql.k")
	if err != nil {
		panic(err)
	}

	kclEsoTemplate, err = build.LoadTemplate("compositions/rds-base/templates/provision-eso.k")
	if err != nil {
		panic(err)
	}

	kclFooter := "items = _items"

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
					Source: strings.Join([]string{kclCommon, kclCreateClusterTemplate, kclFooter}, "\n\n"),
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
					Source: strings.Join([]string{kclCommon, kclResourcesTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-patching").
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
					Source: strings.Join([]string{kclCommon, kclPatchTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-provision-eso").
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
					Source: strings.Join([]string{kclCommon, kclEsoTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-provision-sql").
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
					Source: strings.Join([]string{kclCommon, kclSqlTemplate, kclFooter}, "\n\n"),
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
