// Copyright <YEAR> The <REPO> Authors.
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
	"<REPO_NAME>/<BASE_PATH>/<GROUP_NAME>/v1alpha1"

	xapiextv1 "github.com/crossplane/crossplane/apis/apiextensions/v1"
	"github.com/mproffitt/crossbuilder/pkg/generate/composition/build"
)

type builder struct{}

var Builder = builder{}
var TemplateBasePath string

func (b *builder) GetCompositeTypeRef() build.ObjectKindReference {
	return build.ObjectKindReference{
		GroupVersionKind: v1alpha1.<GROUP_CLASS>GroupVersionKind,
		Object:           &v1alpha1.<GROUP_CLASS>{},
	}
}

func (b *builder) Build(c build.CompositionSkeleton) {
	c.WithName("<COMPOSITION>").
		WithMode(xapiextv1.CompositionModePipeline).
		WithLabels(map[string]string{
			// Add labels for uniquely identifying this composition
		})

	build.SetBasePath(TemplateBasePath)

	// Add pipeline steps here

	// Add the auto-ready function at the end
	// This ensures the XR is marked ready when all
	//   created MRs are ready
	c.NewPipelineStep("function-auto-ready").
		WithFunctionRef(xapiextv1.FunctionReference{
			Name: "function-auto-ready",
		})

}
