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
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.vpcId"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.vpcId"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.region"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.region"),
				},
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("commontags"),
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("metadata"),
			},
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
							Format: "%s %s rds security group",
						},
					},
					ToFieldPath: cb.StrPtr("spec.forProvider.description"),
				},
			},
		},
	}
}

func createCidrsSecurityGroupRule() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "securitygroup-rule",
		Base: &runtime.RawExtension{
			Object: &ec2v1beta1.SecurityGroupRule{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "ec2.aws.upbound.io/v1beta1",
					Kind:       "SecurityGroupRule",
				},
				Spec: ec2v1beta1.SecurityGroupRuleSpec{
					ForProvider: ec2v1beta1.SecurityGroupRuleParameters_2{
						Type:     cb.StrPtr("ingress"),
						Protocol: cb.StrPtr("tcp"),
					},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.region"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.region"),
				},
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("commontags"),
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("metadata"),
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.securityGroupId"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.securityGroupId"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.cidrBlocks"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.cidrBlocks"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("status.port"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.port"),
				},
			},
		},
	}
}
