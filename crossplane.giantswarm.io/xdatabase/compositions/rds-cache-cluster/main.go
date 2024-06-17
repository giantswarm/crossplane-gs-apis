package main

import (
	"crossbuilder/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	"k8s.io/apimachinery/pkg/runtime"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	xnet "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.RdsCacheClusterGroupVersionKind,
		Object:           &v1alpha1.RdsCacheCluster{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("rds-cache-cluster").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "database",
			"type":      "base",
		})

	var (
		kclPatchTemplate string
		resources        []xpt.ComposedTemplate = createResources()
		err              error
	)

	kclPatchTemplate, err = build.LoadTemplate("compositions/rds-cache-cluster/templates/patching.k")
	if err != nil {
		panic(err)
	}

	c.NewPipelineStep("patch-and-transform").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-patch-and-transform",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xpt.Resources{
				Resources: resources,
			},
		})

	c.NewPipelineStep("function-kcl-dynamic-patch").
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
					Source: kclPatchTemplate,
				},
			},
		})
}

func createResources() []xpt.ComposedTemplate {
	return []xpt.ComposedTemplate{
		{
			Name: "peered-vpc-network",
			Base: &runtime.RawExtension{
				Object: &xnet.PeeredVpcNetwork{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xnetworks.crossplane.giantswarm.io/v1alpha1",
						Kind:       "PeeredVpcNetwork",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.vpc", "spec"),
				cb.FromPatch("spec.region", "spec.region"),
				cb.ToPatch("status.vpcId", "status.atProvider.vpcId"),
			},
		},
		{
			Name: "rds-base",
			Base: &runtime.RawExtension{
				Object: &v1alpha1.RdsBaseDbCluster{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xdatabases.crossplane.giantswarm.io/v1alpha1",
						Kind:       "RdsBaseClaim",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.database", "spec"),
				cb.FromPatch("spec.region", "spec.region"),
			},
		},
	}
}
