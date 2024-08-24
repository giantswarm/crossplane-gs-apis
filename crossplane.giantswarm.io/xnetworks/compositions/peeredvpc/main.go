package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"

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

var TemplateBasePath string

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.PeeredVpcNetworkGroupVersionKind,
		Object:           &v1alpha1.PeeredVpcNetwork{},
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
		kclCommon            string
		kclResourcesTemplate string
		kclPeeringTemplate   string
		kclRamTemplate       string
		kclTransitTemplate   string
		kclPatchTemplate     string
		kclFooter            string                 = "items = _items"
		resources            []xpt.ComposedTemplate = createResources()
	)

	build.SetBasePath(TemplateBasePath)

	kclCommon, err = build.LoadTemplate("templates/common.k")
	if err != nil {
		panic(err)
	}

	kclPatchTemplate, err = build.LoadTemplate("templates/patching.k")
	if err != nil {
		panic(err)
	}

	kclPeeringTemplate, err = build.LoadTemplate("templates/peering.k")
	if err != nil {
		panic(err)
	}

	kclRamTemplate, err = build.LoadTemplate("templates/ram.k")
	if err != nil {
		panic(err)
	}

	kclResourcesTemplate, err = build.LoadTemplate("templates/resources.k")
	if err != nil {
		panic(err)
	}

	kclTransitTemplate, err = build.LoadTemplate("templates/transitgw.k")
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
					EnabledRef:        "status.vpcLookup.enabled",
					GroupByRef:        "status.vpcLookup.groupBy",
					ProviderType:      "aws",
					ProviderConfigRef: "spec.providerConfigRef",
					RegionRef:         "spec.region",
					VpcNameRef:        "status.vpcLookup.remoteVpcs",
					PatchTo:           "status.vpcs",
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
					Source: strings.Join([]string{kclCommon, kclResourcesTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-create-peering").
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
					Source: strings.Join([]string{kclCommon, kclPeeringTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-ram").
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
					Source: strings.Join([]string{kclCommon, kclRamTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-create-transit-gateway").
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
					Source: strings.Join([]string{kclCommon, kclTransitTemplate, kclFooter}, "\n\n"),
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
					Source: strings.Join([]string{kclCommon, kclPatchTemplate, kclFooter}, "\n\n"),
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

func createResources() []xpt.ComposedTemplate {
	var resources []xpt.ComposedTemplate = []xpt.ComposedTemplate{
		createVpcResource(),
		createDefaultSgControl(),
		// createInternetGateway(),
	}

	return resources
}
