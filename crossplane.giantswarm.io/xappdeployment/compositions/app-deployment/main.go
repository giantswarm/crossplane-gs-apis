package main

import (
	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xappdeployment/v1alpha1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
)

type builder struct{}

var Builder = builder{}
var TemplateBasePath string

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.AppDeploymentGroupVersionKind,
		Object:           &v1alpha1.AppDeployment{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("app-deployment").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			// Add labels for uniquely identifying this composition
		})

	build.SetBasePath(TemplateBasePath)

	// Add pipeline steps here

	// Add the auto-ready function at the end
	// This ensures the XR is marked ready when all
	//   created MRs are ready
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}
