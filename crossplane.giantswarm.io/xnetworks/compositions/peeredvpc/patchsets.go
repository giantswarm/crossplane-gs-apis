package main

import xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"

func metadataPatchSet() xpt.PatchSet {
	return xpt.PatchSet{
		Name: "metadata",
		Patches: []xpt.PatchSetPatch{
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("metadata.labels"),
					ToFieldPath:   strPtr("metadata.labels"),
					Policy:        toPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.region"),
					ToFieldPath:   strPtr("metadata.labels.region"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.providerConfigRef"),
					ToFieldPath:   strPtr("spec.providerConfigRef"),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.deletionPolicy"),
					ToFieldPath:   strPtr("spec.deletionPolicy"),
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
					FromFieldPath: strPtr("spec.tags.common"),
					ToFieldPath:   strPtr("spec.forProvider.tags"),
					Policy:        toPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("metadata.labels"),
					ToFieldPath:   strPtr("spec.forProvider.tags"),
					Policy:        toPatchPolicy(xpt.ToFieldPathPolicyMergeObjects),
				},
			},
			{
				Type: xpt.PatchTypeFromCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("spec.region"),
					ToFieldPath:   strPtr("spec.forProvider.tags.region"),
				},
			},
		},
	}
}
