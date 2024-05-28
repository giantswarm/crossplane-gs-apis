package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	v1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	ec2v1beta1 "github.com/upbound/provider-aws/apis/ec2/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createInternetGateway() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "internet-gateway",
		Base: &runtime.RawExtension{
			Object: &ec2v1beta1.InternetGateway{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "ec2.aws.upbound.io/v1beta1",
					Kind:       "InternetGateway",
				},
				Spec: ec2v1beta1.InternetGatewaySpec{
					ForProvider: ec2v1beta1.InternetGatewayParameters_2{
						VPCIDSelector: &v1.Selector{
							MatchControllerRef: boolPtr(true),
						},
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
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: strPtr("commontags"),
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: strPtr("metadata"),
			},
			combineNameRegionPatch("spec.forProvider.tags.Name", "-igw"),
			combineNameRegionPatch("metadata.name", ""),
			{
				Type: xpt.PatchTypeToCompositeFieldPath,
				Patch: xpt.Patch{
					ToFieldPath:   strPtr("status.vpcs.self.internetGateway"),
					FromFieldPath: strPtr("status.atProvider.id"),
				},
			},
		},
	}
}
