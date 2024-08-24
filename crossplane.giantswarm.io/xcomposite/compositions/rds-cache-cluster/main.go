package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xcomposite/v1alpha1"

	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	"k8s.io/apimachinery/pkg/runtime"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	xcache "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xcache/v1alpha1"
	xdb "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xdatabase/v1alpha1"
	xnet "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.RdsCacheClusterGroupVersionKind,
		Object:           &v1alpha1.RdsCacheCluster{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("rds-cache-cluster").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider":  "aws",
			"component": "database",
			"type":      "base",
		})

	var (
		kclPatchTemplate  string
		kclEsoTemplate    string
		kclCommonTemplate string
		resources         []xpt.ComposedTemplate = createResources()
		err               error
	)

	kclPatchTemplate, err = build.LoadTemplate("compositions/rds-cache-cluster/templates/patching.k")
	if err != nil {
		panic(err)
	}

	kclEsoTemplate, err = build.LoadTemplate("compositions/rds-cache-cluster/templates/eso-flux-enablement.k")
	if err != nil {
		panic(err)
	}

	kclCommonTemplate, err = build.LoadTemplate("compositions/rds-cache-cluster/templates/common.k")
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
				PatchSets: []xpt.PatchSet{
					metadataPatchSet(),
					commonPatchSet(),
				},
				Resources: resources,
			},
		})

	c.NewPipelineStep("function-kcl-create-eso-secret").
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
					Source: strings.Join([]string{kclCommonTemplate, kclEsoTemplate, "items = _items"}, "\n\n"),
				},
			},
		})

	c.NewPipelineStep("function-kcl-dynamic-patch").
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
					Source: strings.Join([]string{kclCommonTemplate, kclPatchTemplate}, "\n\n"),
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
			Name: "peered-vpc-network",
			Base: &runtime.RawExtension{
				Object: &xnet.PeeredVpcNetwork{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xnetworks.crossplane.giantswarm.io/v1alpha1",
						Kind:       "PeeredVpcNetwork",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.vpc", "spec"),
				cb.FromPatch("spec.availabilityZones", "spec.availabilityZones"),
				cb.FromPatch("spec.claimRef", "spec.claimRef"),
				cb.FromPatch("spec.deletionPolicy", "spec.deletionPolicy"),
				cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
				cb.FromPatch("spec.region", "spec.region"),
				cb.FromPatch("spec.providerConfigRef", "spec.providerConfigRef"),
				cb.ToPatch("status.vpc", "status.vpcs.self"),
			},
		},
		{
			Name: "cache-base",
			Base: &runtime.RawExtension{
				Object: &xcache.CacheBase{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xcache.crossplane.giantswarm.io/v1alpha1",
						Kind:       "CacheBase",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.cache", "spec"),
				cb.FromPatch("spec.availabilityZones", "spec.availabilityZones"),
				cb.FromPatch("spec.claimRef", "spec.claimRef"),
				cb.FromPatch("spec.deletionPolicy", "spec.deletionPolicy"),
				cb.FromPatch("spec.eso", "spec.eso"),
				cb.FromPatch("spec.kubernetesProviderConfig", "spec.kubernetesProviderConfig"),
				cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
				cb.FromPatch("spec.providerConfigRef", "spec.providerConfigRef"),
				cb.FromPatch("spec.region", "spec.region"),
				{
					Type: xpt.PatchTypeFromCompositeFieldPath,
					Patch: xpt.Patch{
						FromFieldPath: cb.StrPtr("status.vpc.id"),
						ToFieldPath:   cb.StrPtr("spec.vpcId"),
						Policy: &xpt.PatchPolicy{
							FromFieldPath: &required,
						},
					},
				},
				cb.ToPatch("status.cacheClusterEndpoints", "status.clusterEndpoints"),
				cb.ToPatch("status.cacheEndpoint", "status.endpoint"),
				cb.ToPatch("status.cacheReaderEndpoint", "status.readerEndpoint"),
				cb.ToPatch("status.cacheGlobalConnectionSecret", "status.globalConnectionSecret"),
				cb.ToPatch("status.cacheGlobalEndpoint", "status.globalEndpoint"),
				cb.ToPatch("status.cacheGlobalReaderEndpoint", "status.globalReaderEndpoint"),
				cb.ToPatch("status.cachePort", "status.port"),
			},
		},
		{
			Name: "rds-base",
			Base: &runtime.RawExtension{
				Object: &xdb.RdsBase{
					TypeMeta: metav1.TypeMeta{
						APIVersion: "xdatabase.crossplane.giantswarm.io/v1alpha1",
						Kind:       "RdsBase",
					},
				},
			},
			Patches: []xpt.ComposedPatch{
				cb.FromPatch("spec.database", "spec"),
				cb.FromPatch("spec.availabilityZones", "spec.availabilityZones"),
				cb.FromPatch("spec.claimRef", "spec.claimRef"),
				cb.FromPatch("spec.deletionPolicy", "spec.deletionPolicy"),
				cb.FromPatch("spec.eso", "spec.eso"),
				cb.FromPatch("spec.kubernetesProviderConfig", "spec.kubernetesProviderConfig"),
				cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
				cb.FromPatch("spec.providerConfigRef", "spec.providerConfigRef"),
				cb.FromPatch("spec.region", "spec.region"),
				{
					Type: xpt.PatchTypeFromCompositeFieldPath,
					Patch: xpt.Patch{
						FromFieldPath: cb.StrPtr("status.vpc.id"),
						ToFieldPath:   cb.StrPtr("spec.vpcId"),
						Policy: &xpt.PatchPolicy{
							FromFieldPath: &required,
						},
					},
				},
				cb.ToPatch("status.rdsEndpoint", "status.endpoint"),
				cb.ToPatch("status.rdsPort", "status.port"),
			},
		},
	}
}
