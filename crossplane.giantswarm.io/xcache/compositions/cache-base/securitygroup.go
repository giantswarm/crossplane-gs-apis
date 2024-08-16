package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	ec2v1beta1 "github.com/upbound/provider-aws/apis/ec2/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createSecurityGroup() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "securitygroup",
		Base: &runtime.RawExtension{
			Object: &ec2v1beta1.SecurityGroup{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "ec2.aws.upbound.io/v1beta1",
					Kind:       "SecurityGroup",
				},
				Spec: ec2v1beta1.SecurityGroupSpec{
					ForProvider: ec2v1beta1.SecurityGroupParameters_2{
						RevokeRulesOnDelete: cb.BoolPtr(true),
					},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			cb.FromPatch("spec.vpcId", "spec.forProvider.vpcId"),
			cb.FromPatch("spec.region", "spec.forProvider.region"),
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("commontags"),
			},
			cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("metadata"),
			},
			cb.FromPatchMergeObjects("spec.claimRef.name", "spec.forProvider.tags.Name"),
			{
				Type: xpt.PatchTypeCombineFromComposite,
				Patch: xpt.Patch{
					Combine: &xpt.Combine{
						Variables: []xpt.CombineVariable{
							{
								FromFieldPath: "spec.claimRef.name",
							},
							{
								FromFieldPath: "spec.region",
							},
						},
						Strategy: xpt.CombineStrategyString,
						String: &xpt.StringCombine{
							Format: "%s %s elasticache security group",
						},
					},
					ToFieldPath: cb.StrPtr("spec.forProvider.description"),
				},
			},
			cb.ToPatch("status.securityGroupId", "status.atProvider.id"),
		},
	}
}
