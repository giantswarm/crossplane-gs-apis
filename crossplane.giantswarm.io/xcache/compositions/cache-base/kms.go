package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	kmsv1beta1 "github.com/upbound/provider-aws/apis/kms/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createKmsResource() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "kms",
		Base: &runtime.RawExtension{
			Object: &kmsv1beta1.Key{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "kms.aws.upbound.io/v1beta1",
					Kind:       "Key",
				},
				Spec: kmsv1beta1.KeySpec{
					ForProvider: kmsv1beta1.KeyParameters{},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			cb.FromPatch("spec.region", "spec.forProvider.region"),
			cb.ToPatch("status.kmsKeyId", "status.atProvider.arn"),
			cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),

			combineNameRegionPatch("spec.forProvider.tags.Name", ""),
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("commontags"),
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("metadata"),
			},
		},
	}
}
