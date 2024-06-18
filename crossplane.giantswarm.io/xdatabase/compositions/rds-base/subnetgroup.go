package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	rdsv1beta1 "github.com/upbound/provider-aws/apis/rds/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createSubnetGroup() xpt.ComposedTemplate {
	required := xpt.FromFieldPathPolicyRequired
	return xpt.ComposedTemplate{
		Name: "subnetgroup",
		Base: &runtime.RawExtension{
			Object: &rdsv1beta1.SubnetGroup{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "rds.aws.upbound.io/v1beta1",
					Kind:       "SubnetGroup",
				},
				Spec: rdsv1beta1.SubnetGroupSpec{
					ForProvider: rdsv1beta1.SubnetGroupParameters{},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			cb.FromPatch("spec.region", "spec.forProvider.region"),
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.subnetIds"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.subnetIds"),
					Policy: &xpt.PatchPolicy{
						FromFieldPath: &required,
					},
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
			cb.ToPatch("status.dbSubnetGroupName", "status.atProvider.id"),
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
							Format: "%s %s rds subnet group",
						},
					},
					ToFieldPath: cb.StrPtr("spec.forProvider.description"),
				},
			},
		},
	}
}
