package main

import (
	"fmt"

	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
)

func patchSubnets(public bool, slen int) []xpt.ComposedTemplate {
	var templates []xpt.ComposedTemplate = make([]xpt.ComposedTemplate, 0)

	for i := 0; i < slen; i++ {
		var patches []xpt.ComposedPatch = make([]xpt.ComposedPatch, 0)
		var visibility string = "public"
		if !public {
			visibility = "private"
		}

		patches = append(patches, xpt.ComposedPatch{
			Type:         xpt.PatchTypePatchSet,
			PatchSetName: strPtr("metadata"),
		})

		patches = append(patches, xpt.ComposedPatch{
			Type: xpt.PatchTypeFromCompositeFieldPath,
			Patch: xpt.Patch{
				FromFieldPath: strPtr("status.id"),
				ToFieldPath:   strPtr("spec.vpcId"),
			},
		})

		var az []string = []string{"a", "b", "c"}

		for i := 0; i < len(az); i++ {
			var toPath string = fmt.Sprintf("status.subnets.%s[%d].%s", visibility, i, az[i])
			patches = append(patches, xpt.ComposedPatch{
				Type: xpt.PatchTypeToCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("status.subnets." + az[i]),
					ToFieldPath:   strPtr(toPath),
				},
			})

			toPath = fmt.Sprintf("status.routeTables.%s[%d].%s", visibility, i, az[i])
			patches = append(patches, xpt.ComposedPatch{
				Type: xpt.PatchTypeToCompositeFieldPath,
				Patch: xpt.Patch{
					FromFieldPath: strPtr("status.routeTables." + az[i]),
					ToFieldPath:   strPtr(toPath),
				},
			})
		}
		templates = append(templates, xpt.ComposedTemplate{
			Name:    visibility + "-subnets-" + fmt.Sprintf("%d", i),
			Patches: patches,
		})
	}
	return templates
}
