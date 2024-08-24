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
		GroupVersionKind: v1alpha1.PeeringGroupVersionKind,
		Object:           &v1alpha1.Peering{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("vpcpeering").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "networking",
			"type":      "peering",
		})

	// Load the template
	var (
		err                error
		kclCommon          string
		kclPeeringTemplate string
		kclFooter          string = "items = _items"
	)

	kclCommon, err = build.LoadTemplate("compositions/peering/templates/common.k")
	if err != nil {
		panic(err)
	}

	kclPeeringTemplate, err = build.LoadTemplate("compositions/peering/templates/resources.k")
	if err != nil {
		panic(err)
	}

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

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}
