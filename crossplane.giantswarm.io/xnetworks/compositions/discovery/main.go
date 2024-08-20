package main

import (
	// "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"
	"crossbuilder/v1alpha1"

	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	xnd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"

	ccObject "github.com/crossplane-contrib/provider-kubernetes/apis/object/v1alpha2"
	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.DiscoveryGroupVersionKind,
		Object:           &v1alpha1.Discovery{},
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
					ProviderConfigRef: "spec.providerConfigRef",
					RegionRef:         "spec.region",
					VpcNameRef:        "spec.remoteVpcs",
					PatchTo:           "status.vpcs",
				},
			},
		})

	toJson := xpt.StringConversionTypeToJSON
	c.NewPipelineStep("function-patch-and-transform").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-patch-and-transform",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xpt.Resources{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "pt.fn.crossplane.io/v1beta1",
					Kind:       "Resources",
				},
				Resources: []xpt.ComposedTemplate{
					{
						Name: "configmap",
						Base: &runtime.RawExtension{
							Object: &ccObject.Object{
								TypeMeta: metav1.TypeMeta{
									APIVersion: "kubernetes.crossplane.io/v1alpha2",
									Kind:       "Object",
								},
								Spec: ccObject.ObjectSpec{
									ForProvider: ccObject.ObjectParameters{
										Manifest: runtime.RawExtension{
											Raw: []byte(`{"apiVersion": "v1",
												"kind": "ConfigMap",
												"metadata": {
											  		"name": "",
													"namespace": ""
												},
												"spec": {
											  		"data": {}
												}
											}`),
										},
									},
								},
							},
						},
						Patches: []xpt.ComposedPatch{
							cb.FromPatch("spec.claimRef.name", "metadata.name"),
							cb.FromPatch("spec.kubernetesProviderConfigRef", "spec.providerConfigRef"),
							cb.FromPatch("spec.claimRef.namespace", "spec.forProvider.manifest.metadata.namespace"),

							{
								Type: xpt.PatchTypeFromCompositeFieldPath,
								Patch: xpt.Patch{
									FromFieldPath: strPtr("spec.claimRef.name"),
									ToFieldPath:   strPtr("spec.forProvider.manifest.metadata.name"),
									Transforms: []xpt.Transform{
										{
											Type: xpt.TransformTypeString,
											String: &xpt.StringTransform{
												Type:   xpt.StringTransformTypeFormat,
												Format: strPtr("%s-network-discovery"),
											},
										},
									},
								},
							},
							{
								Type: xpt.PatchTypeFromCompositeFieldPath,
								Patch: xpt.Patch{
									FromFieldPath: strPtr("status.vpcs"),
									ToFieldPath:   strPtr("spec.forProvider.manifest.data.vpcs"),
									Transforms: []xpt.Transform{
										{
											Type: xpt.TransformTypeString,
											String: &xpt.StringTransform{
												Type:    xpt.StringTransformTypeConvert,
												Convert: &toJson,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		})
}

func strPtr(s string) *string {
	return &s
}
