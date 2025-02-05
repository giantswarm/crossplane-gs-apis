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

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
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

	build.SetBasePath(TemplateBasePath)

	// Pull GitHub app credentials from secret
	c.NewPipelineStep("pull-extra-resources").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-extra-resources",
		}).
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

	// Add the auto-ready function at the end
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}
