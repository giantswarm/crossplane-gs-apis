package main

import (
	"strings"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xlaszlo/v1alpha1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}
var TemplateBasePath string

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.ExampleGroupVersionKind,
		Object:           &v1alpha1.Example{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("test").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			// Add labels for uniquely identifying this composition
		})

	build.SetBasePath(TemplateBasePath)

	kclCommon, err := build.LoadTemplate("templates/common.k")
	if err != nil {
		panic(err)
	}

	kclConfigMapemplate, err := build.LoadTemplate("templates/provision-configmap.k")
	if err != nil {
		panic(err)
	}

	kclLogicalDatabaseTemplate, err := build.LoadTemplate("templates/provision-logical-database.k")
	if err != nil {
		panic(err)
	}

	kclHelmReleaseTemplate, err := build.LoadTemplate("templates/provision-helmrelease.k")
	if err != nil {
		panic(err)
	}

	kclFooter := "items = _items"

	// Add pipeline steps here
	c.NewPipelineStep("function-provision-configmap").
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
					Source: strings.Join([]string{kclCommon, kclConfigMapemplate, kclLogicalDatabaseTemplate, kclHelmReleaseTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	// Add the auto-ready function at the end
	// This ensures the XR is marked ready when all
	//   created MRs are ready
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}
