package main

import (
	"crossbuilder/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	ccKubernetes "github.com/crossplane-contrib/provider-kubernetes/apis/object/v1alpha2"
	capi "sigs.k8s.io/cluster-api/api/v1beta1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.RCCWithRegionLookupGroupVersionKind,
		Object:           &v1alpha1.RCCWithRegionLookup{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("rcc-with-region-lookup").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "aws",
			"type":      "regionlookup",
		})

	var (
		kclResourceTemplate string
		resources           []xpt.ComposedTemplate = createResources()
		err                 error
	)

	kclResourceTemplate, err = build.LoadTemplate("compositions/rccwithregionlookup/templates/resources.k")
	if err != nil {
		panic(err)
	}

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
				Resources: resources,
			},
		})

	c.NewPipelineStep("function-kcl-resources").
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
					Source: kclResourceTemplate,
				},
			},
		})

	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}

func createResources() []xpt.ComposedTemplate {
	required := xpt.FromFieldPathPolicyRequired
	return []xpt.ComposedTemplate{
		{
			Name: "cluster-lookup",
			Base: &runtime.RawExtension{
				Object: &ccKubernetes.Object{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "kubernetes.crossplane.io/v1alpha2",
						Kind:       "Object",
					},
					Spec: ccKubernetes.ObjectSpec{
						ResourceSpec: xpv1.ResourceSpec{
							ManagementPolicies: xpv1.ManagementPolicies{
								xpv1.ManagementActionObserve,
							},
							ProviderConfigReference: &xpv1.Reference{
								Name: "test-provider",
							},
							DeletionPolicy: xpv1.DeletionDelete,
						},
						ForProvider: ccKubernetes.ObjectParameters{
							Manifest: runtime.RawExtension{
								Object: &capi.Cluster{
									TypeMeta: metav1.TypeMeta{
										APIVersion: "cluster.x-k8s.io/v1beta1",
										Kind:       "Cluster",
									},
									ObjectMeta: metav1.ObjectMeta{
										Name:      "test-cluster",
										Namespace: "test-namespace",
									},
								},
							},
						},
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.clusterDiscovery.name", "spec.forProvider.manifest.metadata.name"),
				cb.FromPatch("spec.clusterDiscovery.namespace", "spec.forProvider.manifest.metadata.namespace"),
				cb.FromPatch("spec.clusterDiscovery.deletionPolicy", "spec.deletionPolicy"),
			},
		},
		{
			Name: "rds-cache-cluster",
			Base: &runtime.RawExtension{
				Object: &v1alpha1.RdsCacheCluster{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xdatabase.crossplane.giantswarm.io/v1alpha1",
						Kind:       "RdsCacheCluster",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.rdsCacheClusterSpec", "spec"),
				{
					Type: xpt.PatchTypeFromCompositeFieldPath,
					Patch: xpt.Patch{
						FromFieldPath: cb.StrPtr("status.region"),
						ToFieldPath:   cb.StrPtr("spec.region"),
						Policy: &xpt.PatchPolicy{
							FromFieldPath: &required,
						},
					},
				},
				{
					Type: xpt.PatchTypeFromCompositeFieldPath,
					Patch: xpt.Patch{
						FromFieldPath: cb.StrPtr("status.availabilityZones"),
						ToFieldPath:   cb.StrPtr("spec.availabilityZones"),
						Policy: &xpt.PatchPolicy{
							FromFieldPath: &required,
						},
					},
				},
				cb.ToPatch("status.cacheClusterEndpoints", "status.cacheClusterEndpoints"),
				cb.ToPatch("status.cacheConnectionSecret", "status.cacheConnectionSecret"),
				cb.ToPatch("status.cacheEndpoint", "status.cacheEndpoint"),
				cb.ToPatch("status.cacheGlobalConnectionSecret", "status.cacheGlobalConnectionSecret"),
				cb.ToPatch("status.cacheGlobalEndpoint", "status.cacheGlobalEndpoint"),
				cb.ToPatch("status.cacheGlobalReaderEndpoint", "status.cacheGlobalReaderEndpoint"),
				cb.ToPatch("status.cachePort", "status.cachePort"),
				cb.ToPatch("status.cacheReaderEndpoint", "status.cacheReaderEndpoint"),
				cb.ToPatch("status.cacheSubnets", "status.cacheSubnets"),
				cb.ToPatch("status.rdsConnectionSecret", "status.rdsConnectionSecret"),
				cb.ToPatch("status.rdsEndpoint", "status.rdsEndpoint"),
				cb.ToPatch("status.rdsPort", "status.rdsPort"),
				cb.ToPatch("status.rdsSubnets", "status.rdsSubnets"),
				cb.ToPatch("status.vpc", "status.vpc"),
			},
		},
	}
}
