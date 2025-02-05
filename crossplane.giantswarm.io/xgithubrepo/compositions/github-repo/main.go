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
	"github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xgithubrepo/v1alpha1"

	xextrares "github.com/crossplane-contrib/function-extra-resources/input/v1beta1"
	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type builder struct{}

var Builder = builder{}
var TemplateBasePath string

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
							Into: "githubAppCredentials",
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
		/*
					WithInput(map[string]interface{}{
						"apiVersion": "extra-resources.fn.crossplane.io/v1beta1",
						"kind":       "Input",
						"spec": map[string]interface{}{
							"extraResources": []map[string]interface{}{
								{
									"kind":       "Secret",
									"apiVersion": "v1",
									"into":       "githubAppCredentials",
									"type":       "Selector",
									"selector": map[string]interface{}{
										"maxMatch": 2,
										"minMatch": 1,
										"matchLabels": []map[string]interface{}{
											{
												"key":   "secret",
												"type":  "Value",
												"value": "github-app",
											},
										},
									},
								},
							},
						},
					})
			/*
				// Get GitHub token using app credentials
				c.NewPipelineStep("run-the-template").
					WithFunctionRef(xapiextv1.FunctionReference{
						Name: "function-github-app-get-token",
					}).
					WithInput(map[string]interface{}{
						"apiVersion": "template.fn.crossplane.io/v1beta1",
						"kind":       "Input",
						"secretKey":  "githubAppCredentials",
					})

				// Execute shell command with token
				c.NewPipelineStep("shell").
					WithFunctionRef(xapiextv1.FunctionReference{
						Name: "function-shell",
					}).
					WithInput(map[string]interface{}{
						"apiVersion": "shell.fn.crossplane.io/v1beta1",
						"kind":       "Parameters",
						"shellEnvVars": []map[string]interface{}{
							{
								"key":      "GITHUB_TOKEN",
								"valueRef": "context[apiextensions.crossplane.io/github-app-get-token].github-token",
							},
						},
						"shellCommand": "echo \"GITHUB_TOKEN: $GITHUB_TOKEN\"",
						"stdoutField": "status.atFunction.shell.stdout",
						"stderrField": "status.atFunction.shell.stderr",
					})
		*/
	// Add the auto-ready function at the end
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}
