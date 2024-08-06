package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	ec2v1beta1 "github.com/upbound/provider-aws/apis/ec2/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

// Creates a new VPC resource.
func createVpcResource() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "vpc",
		Base: &runtime.RawExtension{
			Object: &ec2v1beta1.VPC{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "ec2.aws.upbound.io/v1beta1",
					Kind:       "VPC",
				},
				Spec: ec2v1beta1.VPCSpec{
					ForProvider: ec2v1beta1.VPCParameters_2{
						EnableDNSSupport:   boolPtr(true),
						EnableDNSHostnames: boolPtr(true),
					},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.region"),
					ToFieldPath:   strPtr("spec.forProvider.region"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.subnetsets.cidrs[0].prefix"),
					ToFieldPath:   strPtr("spec.forProvider.cidrBlock"),
				},
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: strPtr("commontags"),
			},
			cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.claimRef.name"),
					ToFieldPath:   strPtr("spec.forProvider.tags.Name"),
				},
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: strPtr("metadata"),
			},
			{
				Type: xpt.PatchTypeToCompositeFieldPath,
				Patch: xpt.Patch{
					ToFieldPath:   strPtr("status.vpcs.self.id"),
					FromFieldPath: strPtr("status.atProvider.id"),
				},
			},
		},
	}
}
