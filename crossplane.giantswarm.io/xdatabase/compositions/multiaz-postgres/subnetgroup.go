package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	rdsv1beta1 "github.com/upbound/provider-aws/apis/rds/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createSubnetGroup() xpt.ComposedTemplate {
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
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.region"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.region"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.subnetIds"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.subnetIds"),
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
				Type: xpt.PatchTypeToCompositeFieldPath,
				Patch: xpt.Patch{
					ToFieldPath:   cb.StrPtr("status.dbSubnetGroupName"),
					FromFieldPath: cb.StrPtr("status.atProvider.id"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.subnetIds"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.subnetIds"),
				},
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
							Format: "%s %s rds subnet group",
						},
					},
					ToFieldPath: cb.StrPtr("spec.forProvider.description"),
				},
			},
		},
	}
}
