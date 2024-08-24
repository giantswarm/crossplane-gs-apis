package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xdatabase/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.RdsProvisioningGroupVersionKind,
		Object:           &v1alpha1.RdsProvisioning{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("rds-provisioning").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "database",
			"type":      "provisioning",
		})

	var (
		kclCommon      string
		kclSqlTemplate string
		err            error
	)

	kclCommon, err = build.LoadTemplate("compositions/rds-provisioning/templates/common.k")
	if err != nil {
		panic(err)
	}

	kclSqlTemplate, err = build.LoadTemplate("compositions/rds-provisioning/templates/provision-sql.k")
	if err != nil {
		panic(err)
	}

	kclFooter := "items = _items"

	c.NewPipelineStep("function-provision-sql").
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
					Source: strings.Join([]string{kclCommon, kclSqlTemplate, kclFooter}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}
