package main

import (
	"fmt"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"

	xgt "github.com/crossplane-contrib/function-go-templating/input/v1beta1"
	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	xnd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/input/v1beta1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	cidr "github.com/mproffitt/function-cidr/input/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.PeeredVpcNetworkGroupVersionKind,
		Object:           &xgt.GoTemplate{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("peered-vpc-network").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "networking",
			"type":      "vpc",
		})

	// Load the template
	var (
		err                  error
		kclSubnetsTemplate   string
		kclResourcesTemplate string
		kclPatchTemplate     string
		resources            []xpt.ComposedTemplate = createResources()
	)

	kclSubnetsTemplate, err = build.LoadTemplate("compositions/peeredvpc/templates/subnets.k")
	if err != nil {
		panic(err)
	}

	kclResourcesTemplate, err = build.LoadTemplate("compositions/peeredvpc/templates/resources.k")
	if err != nil {
		panic(err)
	}

	kclPatchTemplate, err = build.LoadTemplate("compositions/peeredvpc/templates/patching.k")
	if err != nil {
		panic(err)
	}

	c.NewPipelineStep("network-discovery").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-network-discovery",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xnd.Input{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "xnetworks.crossplane.giantswarm.io/v1beta1",
					Kind:       "Input",
				},
				Spec: &xnd.Spec{
					EnabledRef:        "spec.peering.enabled",
					GroupByRef:        "spec.peering.groupBy",
					ProviderConfigRef: "spec.providerConfigRef.name",
					RegionRef:         "spec.region",
					VpcNameRef:        "spec.peering.remoteVpcs",
					PatchTo:           "status.vpcs",
				},
			},
		})

	c.NewPipelineStep("function-kcl-subnet-bits").
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
					Source: kclSubnetsTemplate,
				},
			},
		})

	c.NewPipelineStep("function-cidr").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-cidr",
		}).
		WithInput(build.ObjectKindReference{
			Object: &cidr.Parameters{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "cidr.fn.crossplane.io/v1beta1",
					Kind:       "Parameters",
				},
				CidrFunc:         "multiprefixloop",
				MultiPrefixField: "status.subnetBits",
				OutputField:      "status.calculatedCidrs",
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

	c.NewPipelineStep("function-kcl-patch-xr").
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

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}

func toPatchPolicy(policy xpt.ToFieldPathPolicy) *xpt.PatchPolicy {
	return &xpt.PatchPolicy{
		ToFieldPath: &policy,
	}
}

func boolPtr(b bool) *bool {
	return &b
}

func strPtr(s string) *string {
	return &s
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
			ToFieldPath: strPtr(toFieldPath),
		},
	}
}

func createResources() []xpt.ComposedTemplate {
	var resources []xpt.ComposedTemplate = []xpt.ComposedTemplate{
		createVpcResource(),
		createDefaultSgControl(),
		createInternetGateway(),
	}

	return resources
}
