package main

import (
	// "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"
	"crossbuilder/v1alpha1"

	xgt "github.com/crossplane-contrib/function-go-templating/input/v1beta1"
	xnd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.DiscoveryGroupVersionKind,
		Object:           &xgt.GoTemplate{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("network-discovery").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "networking",
			"type":      "discovery",
		})

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
					EnabledRef:        "spec.enabled",
					GroupByRef:        "spec.groupBy",
					ProviderType:      "aws",
					ProviderConfigRef: "spec.providerConfigRef.name",
					RegionRef:         "spec.region",
					VpcNameRef:        "spec.remoteVpcs",
					PatchTo:           "status.vpcs",
				},
			},
		})
}
