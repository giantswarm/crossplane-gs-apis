// Copyright 2025 The crossplane-gs-apis Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"strings"

	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xgithubrepo/v1alpha1"

	xextrares "github.com/crossplane-contrib/function-extra-resources/input/v1beta1"
	xkcl "github.com/crossplane-contrib/function-kcl/input/v1beta1"
	xfunsh "github.com/crossplane-contrib/function-shell/input/v1alpha1"
	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	xghtoken "github.com/giantswarm/function-github-app-get-token/input/v1beta1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var (
	Builder          = builder{}
	TemplateBasePath string
)

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.GithubRepoGroupVersionKind,
		Object:           &v1alpha1.GithubRepo{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("github-repo").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			"provider": "github",
			"type":     "repository",
		})

	var (
		one                             = uint64(1)
		xrGithubAppSecretLabelKey       = "github-app-secret"
		xrGithubAppSecretLabelValuePath = "spec.githubAppSecretLabelValue"
		ctxKeyGithubAppCredentials      = "githubAppCredentials"
	)

	build.SetBasePath(TemplateBasePath)

	// Pull GitHub app credentials from secret
	c.NewPipelineStep("pull-github-secret").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-extra-resources",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xextrares.Input{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "extra-resources.fn.crossplane.io/v1beta1",
					Kind:       "Input",
				},
				Spec: xextrares.InputSpec{
					ExtraResources: []xextrares.ResourceSource{
						{
							// kubernetes object to pull - its Kind
							Kind: "Secret",
							// kubernetes object to pull - its apiVersion
							APIVersion: "v1",
							// name of the crossplane context key to store the result
							Into: ctxKeyGithubAppCredentials,
							// type of function's selector to use: either by direct ref or label matching
							Type: xextrares.ResourceSourceTypeSelector,
							// selector to use to find the object - select by labels
							Selector: &xextrares.ResourceSourceSelector{
								MinMatch: &one,
								MaxMatch: &one,
								MatchLabels: []xextrares.ResourceSourceSelectorLabelMatcher{
									{
										// match by label which value comes from the XR
										Type:               xextrares.ResourceSourceSelectorLabelMatcherTypeFromCompositeFieldPath,
										Key:                xrGithubAppSecretLabelKey,
										ValueFromFieldPath: &xrGithubAppSecretLabelValuePath,
									},
								},
							},
						},
					},
				},
			},
		})

	// get temporary access token using GitHub App auth workflow
	c.NewPipelineStep("get-github-token").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-extra-resources",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xghtoken.Input{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "github-app-get-token.fn.crossplane.giantswarm.io/v1beta1",
					Kind:       "Input",
				},
				SecretKey: ctxKeyGithubAppCredentials,
			},
		})

	// Execute the GitHub provisioning script
	ghBashScript, err := build.LoadTemplate("scripts/clone-render-repo.sh")
	if err != nil {
		panic(err)
	}
	c.NewPipelineStep("execute-gh-script").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-shell",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xfunsh.Parameters{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "template.fn.crossplane.io/v1alpha1",
					Kind:       "Parameters",
				},
				ShellEnvVars: []xfunsh.ShellEnvVar{
					{
						Key:      "GITHUB_TOKEN",
						ValueRef: "context[apiextensions.crossplane.io/github-app-get-token].github-token",
					},
					{
						Key:      "REPO_OWNER",
						ValueRef: "spec.repository.owner",
					},
					{
						Key:      "REPO_NAME",
						ValueRef: "spec.repository.name",
					},
					{
						Key:      "REPO_DESCRIPTION",
						ValueRef: "spec.repository.description",
					},
					{
						Key:      "REPO_VISIBILITY",
						ValueRef: "spec.repository.visibility",
					},
					{
						Key:      "REGISTRY_DOMAIN",
						ValueRef: "ghcr.io",
					},
					{
						Key:      "BACKSTAGE_ENTITY_OWNER",
						ValueRef: "spec.backstageCatalogEntity.owner",
					},
					{
						Key:      "BACKSTAGE_ENTITY_LIFECYCLE",
						ValueRef: "spec.backstageCatalogEntity.lifecycle",
					},
				},
				ShellCommand: ghBashScript,
			},
		})

	// Use KCL to render resources
	kclCommon, err := build.LoadTemplate("templates/common.k")
	if err != nil {
		panic(err)
	}
	kclConfigMap, err := build.LoadTemplate("templates/configmap.k")
	if err != nil {
		panic(err)
	}
	kclHelmRepo, err := build.LoadTemplate("templates/helmrepository.k")
	if err != nil {
		panic(err)
	}
	kclFooter := "items = _items"
	c.NewPipelineStep("function-provision-configmap").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-kcl",
		}).
		WithInput(build.ObjectKindReference{
			Object: &xkcl.KCLInput{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "krm.kcl.dev/v1alpha1",
					Kind:       "KCLInput",
				},
				Spec: xkcl.RunSpec{
					Source: strings.Join([]string{kclCommon, kclConfigMap, kclHelmRepo, kclFooter}, "\n\n"),
				},
			},
		})
	// Add the auto-ready function at the end
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})
}
