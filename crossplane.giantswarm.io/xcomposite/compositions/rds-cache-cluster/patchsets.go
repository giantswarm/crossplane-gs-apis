package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
)

func metadataPatchSet() xpt.PatchSet {
	return xpt.PatchSet{
		Name: "metadata",
		Patches: []xpt.PatchSetPatch{
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("metadata.labels"),
					ToFieldPath:   cb.StrPtr("metadata.labels"),
					Policy:        cb.ToPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.region"),
					ToFieldPath:   cb.StrPtr("metadata.labels.region"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.providerConfigRef"),
					ToFieldPath:   cb.StrPtr("spec.providerConfigRef"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.deletionPolicy"),
					ToFieldPath:   cb.StrPtr("spec.deletionPolicy"),
				},
			},
		},
	}
}

func commonPatchSet() xpt.PatchSet {
	return xpt.PatchSet{
		Name: "commontags",
		Patches: []xpt.PatchSetPatch{
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.tags"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.tags"),
					Policy:        cb.ToPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("metadata.labels"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.tags"),
					Policy:        cb.ToPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: cb.StrPtr("spec.region"),
					ToFieldPath:   cb.StrPtr("spec.forProvider.tags.region"),
				},
			},
		},
	}
}
