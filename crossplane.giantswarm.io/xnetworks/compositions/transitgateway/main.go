package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.TransitGatewayGroupVersionKind,
		Object:           &v1alpha1.TransitGateway{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("transitgateway").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "networking",
			"type":      "transitgateway",
		})

	// Load the template
	var (
		err                  error
		kclCommon            string
		kclFooter            string = "items = _items"
		kclLocalTemplate     string
		kclTgwConfigTemplate string
		kclPeeringTemplate   string
		kclPatchingTemplate  string
		kclRamTemplate       string
		kclRemoteTemplate    string
		kclResourcesTemplate string
	)

	kclCommon, err = build.LoadTemplate("compositions/transitgateway/templates/common.k")
	if err != nil {
		panic(err)
	}

	kclLocalTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/local.k")
	if err != nil {
		panic(err)
	}

	kclPatchingTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/patching.k")
	if err != nil {
		panic(err)
	}

	kclPeeringTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/peering.k")
	if err != nil {
		panic(err)
	}

	// The RAM template is now shared between TGW and PeeredVpc
	// We store it in the peeredvpc composition as the primary source
	kclRamTemplate, err = build.LoadTemplate("compositions/peeredvpc/templates/ram.k")
	if err != nil {
		panic(err)
	}

	kclResourcesTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/resources.k")
	if err != nil {
		panic(err)
	}

	kclRemoteTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/remote.k")
	if err != nil {
		panic(err)
	}

	kclTgwConfigTemplate, err = build.LoadTemplate("compositions/transitgateway/templates/tgw-config.k")
	if err != nil {
		panic(err)
	}

	c.NewPipelineStep("function-kcl-local").
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
					Source: strings.Join([]string{kclCommon, kclLocalTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-tgwconfig").
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
					Source: strings.Join([]string{kclCommon, kclTgwConfigTemplate, kclFooter}, "\n\n"),
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
					Source: strings.Join([]string{kclCommon, kclPatchingTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-peering").
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

	c.NewPipelineStep("function-kcl-remote").
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
					Source: strings.Join([]string{kclCommon, kclRemoteTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}
