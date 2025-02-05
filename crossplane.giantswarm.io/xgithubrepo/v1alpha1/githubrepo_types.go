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

package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	GithubRepoKind      = "GithubRepo"
	GithubRepoGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  GithubRepoKind,
	}.String()
	GithubRepoKindAPIVersion   = GithubRepoKind + "." + GroupVersion.String()
	GithubRepoGroupVersionKind = GroupVersion.WithKind(GithubRepoKind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=ghr
// +crossbuilder:generate:xrd:claimNames:kind=GithubRepoClaim,plural=githubrepoclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=github-repo
type GithubRepo struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   GithubRepoSpec   `json:"spec"`
	Status GithubRepoStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type GithubRepoList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []GithubRepo `json:"items"`
}

// Use the `spec` struct to contain parameters you might not want to share
// when nesting XRDs - these will usually be parameters that may be defined
// in a parent.

type GithubRepoSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	/*                registryInfoConfigMapRef:
	                  description: >-
	                  required:
	                    - name
	                  type: object
	                  properties:
	                    name:
	                      description: Object name.
	                      type: string
	                    namespace:
	                      description: Object's namespace.
	                      type: string
	*/

	GithubRepoParameters `json:",inline"`
}

type GithubRepoParameters struct {
	// The name and namespace of a ConfigMap that has keys named "registry_domain",
	// "registry_username" and "registry_cicd_secret_ref" that configure access to
	// the image registry in the CICD GitHib Action.
	//
	// +required
	RegistryInfoConfigMapRef ConfigMapReference `json:"registryInfoConfigMapRef,omitempty"`
}

type ConfigMapReference struct {
	// Name of the configmap.
	//
	// +required
	Name string `json:"name,omitempty"`

	// Namespace of the configmap
	//
	// +required
	Namespace string `json:"namespace,omitempty"`
}

type GithubRepoStatus struct {
	xpv1.ConditionedStatus `json:",inline"`
}
