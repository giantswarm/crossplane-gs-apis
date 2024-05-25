package main

import (
	"fmt"

	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
)

func patchEips(count int) []xpt.ComposedTemplate {
	var templates []xpt.ComposedTemplate = make([]xpt.ComposedTemplate, 0)

	for i := 0; i < count; i++ {
		templates = append(templates, xpt.ComposedTemplate{
			Name: "eip-" + fmt.Sprintf("%d", i),
			Patches: []xpt.ComposedPatch{
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("metadata"),
				},
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("commontags"),
				},
			},
		})
	}

	return templates
}

func patchInternetGatewayRoutes(resourceCount int) []xpt.ComposedTemplate {
	var templates []xpt.ComposedTemplate = make([]xpt.ComposedTemplate, 0)

	for i := 0; i < resourceCount; i++ {
		templates = append(templates, xpt.ComposedTemplate{
			Name: "igw-route-" + fmt.Sprintf("%d", i),
			Patches: []xpt.ComposedPatch{
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("metadata"),
				},
			},
		})
	}

	return templates
}

func patchNatGatewayRoutes(resourceCount int) []xpt.ComposedTemplate {
	var templates []xpt.ComposedTemplate = make([]xpt.ComposedTemplate, 0)

	for i := 0; i < resourceCount; i++ {
		templates = append(templates, xpt.ComposedTemplate{
			Name: "ngw-route-" + fmt.Sprintf("%d", i),
			Patches: []xpt.ComposedPatch{
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("metadata"),
				},
			},
		})
	}

	return templates
}

func patchNatGateways(resourceCount int) []xpt.ComposedTemplate {
	var templates []xpt.ComposedTemplate = make([]xpt.ComposedTemplate, 0)

	var az []string = []string{"a", "b", "c"}

	for i := 0; i < resourceCount; i++ {
		templates = append(templates, xpt.ComposedTemplate{
			Name: "nat-gateway-" + fmt.Sprintf("%d", i),
			Patches: []xpt.ComposedPatch{
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("metadata"),
				},
				{
					Type:         xpt.PatchTypePatchSet,
					PatchSetName: strPtr("commontags"),
				},
				{
					Type: xpt.PatchTypeToCompositeFieldPath,
					Patch: xpt.Patch{
						ToFieldPath:   strPtr("status.natGateways." + az[i]),
						FromFieldPath: strPtr("status.atProvider.id"),
					},
				},
			},
		})
	}

	return templates
}
