package main

import (
	"fmt"
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xcache/v1alpha1"

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
		GroupVersionKind: v1alpha1.CacheBaseGroupVersionKind,
		Object:           &v1alpha1.CacheBase{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("cache-base").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "elasticache",
			"type":      "base",
		})

	var (
		resources                []xpt.ComposedTemplate = createResources()
		kclCommon                string
		kclUsers                 string
		kclPassword              string
		kclFooter                string = "items = _items"
		replicationGroupTemplate string
		clusterTemplate          string
		patchTemplate            string
		err                      error
	)

	kclCommon, err = build.LoadTemplate("compositions/cache-base/templates/common.k")
	if err != nil {
		panic(err)
	}

	clusterTemplate, err = build.LoadTemplate("compositions/cache-base/templates/cluster.k")
	if err != nil {
		panic(err)
	}

	replicationGroupTemplate, err = build.LoadTemplate("compositions/cache-base/templates/replicationgroup.k")
	if err != nil {
		panic(err)
	}

	kclUsers, err = build.LoadTemplate("compositions/cache-base/templates/users.k")
	if err != nil {
		panic(err)
	}

	kclPassword, err = build.LoadTemplate("compositions/cache-base/templates/password-gen.k")
	if err != nil {
		panic(err)
	}

	patchTemplate, err = build.LoadTemplate("compositions/cache-base/templates/patches.k")
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

	c.NewPipelineStep("function-kcl-create-replicationgroup").
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
					Source: strings.Join([]string{kclCommon, replicationGroupTemplate, kclFooter}, "\n\n"),
				},
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
					Source: strings.Join([]string{kclCommon, clusterTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-create-users").
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
					Source: strings.Join([]string{kclCommon, kclUsers, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-create-password-generator").
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
					Source: strings.Join([]string{kclCommon, kclPassword, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-dynamic-patching").
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
					Source: strings.Join([]string{kclCommon, patchTemplate, kclFooter}, "\n\n"),
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
