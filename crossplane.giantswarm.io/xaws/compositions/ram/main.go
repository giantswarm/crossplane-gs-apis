package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xaws/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}
var TemplateBasePath string

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.ResourceAccessManagerGroupVersionKind,
		Object:           &v1alpha1.ResourceAccessManager{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("resource-access-manager").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "aws",
			"type":      "resource-access-manager",
		})

	// Load the template
	var (
		err            error
		kclCommon      string
		kclRamTemplate string
		kclFooter      string = "items = _items"
	)

	build.SetBasePath(TemplateBasePath)
	kclCommon, err = build.LoadTemplate("templates/common.k")
	if err != nil {
		panic(err)
	}

	kclRamTemplate, err = build.LoadTemplate("templates/resources.k")
	if err != nil {
		panic(err)
	}

	c.NewPipelineStep("function-kcl-create-ram").
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

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}
