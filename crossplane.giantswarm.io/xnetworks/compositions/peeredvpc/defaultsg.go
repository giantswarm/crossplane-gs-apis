package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	v1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	ec2v1beta1 "github.com/upbound/provider-aws/apis/ec2/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

// Creates a new VPC resource.
func createDefaultSgControl() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "default-sg-control",
		Base: &runtime.RawExtension{
			Object: &ec2v1beta1.DefaultSecurityGroup{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "ec2.aws.upbound.io/v1beta1",
					Kind:       "DefaultSecurityGroup",
				},
				Spec: ec2v1beta1.DefaultSecurityGroupSpec{
					ForProvider: ec2v1beta1.DefaultSecurityGroupParameters{
						VPCIDSelector: &v1.Selector{
							MatchControllerRef: boolPtr(true),
						},
						Ingress: []ec2v1beta1.DefaultSecurityGroupIngressParameters{},
						Egress:  []ec2v1beta1.DefaultSecurityGroupEgressParameters{},
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
			cb.FromPatch("spec.managementPolicies", "spec.managementPolicies"),
		},
	}
}
