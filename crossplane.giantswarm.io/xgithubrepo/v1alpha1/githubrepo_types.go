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
	xpv1.ResourceSpec    `json:",inline"`
	GithubRepoParameters `json:",inline"`
}

type BackstageCatalogEntity struct {
	// A reference of the owning Backstage entity.
	//
	// +required
	Owner string `json:"owner,omitempty"`

	// A lifecycle of the Backstage entity.
	//
	// +required
	Lifecycle string `json:"lifecycle,omitempty"`
}

type RepositoryVisibility string

const (
	RepositoryVisibilityPublic   RepositoryVisibility = "public"
	RepositoryVisibilityInternal RepositoryVisibility = "internal"
	RepositoryVisibilityPrivate  RepositoryVisibility = "private"
)

type Repository struct {
	// A name of the owning GitHub organization or user.
	//
	// +required
	Owner string `json:"owner,omitempty"`

	// A name for the new repository.
	//
	// +required
	Name string `json:"name,omitempty"`

	// A description of the new repository.
	//
	// +required
	Description string `json:"description,omitempty"`

	// A full name (`user/repository`) of a GitHub template repository to use.
	//
	// +required
	TemplateSource string `json:"templateSource,omitempty"`

	// Visibility of the created repo.
	//
	// +required
	// +kubebuilder:validation:Enum=public;internal;private
	Visibility RepositoryVisibility `json:"visibility,omitempty"`
}

type ObjectReference struct {
	// Object name.
	//
	// +required
	Name string `json:"name,omitempty"`

	// Object's namespace.
	//
	// +optional
	Namespace string `json:"namespace,omitempty"`
}

type GithubRepoParameters struct {
	// Backstage catalog entity configuration
	//
	// +required
	BackstageCatalogEntity BackstageCatalogEntity `json:"backstageCatalogEntity,omitempty"`

	// New repository configuration.
	//
	// +required
	Repository Repository `json:"repository,omitempty"`

	// In order to load a Secret, it has to hav a label with the key "github-app-secret"
	// and the value indicated in this field.
	//
	// +optional
	GithubAppSecretLabelValue string `json:"githubAppSecretLabelValue,omitempty"`

	// The name and namespace of a ConfigMap that has keys named "registry_domain",
	// "registry_username" and "registry_cicd_secret_ref" that configure access to
	// the image registry in the CICD GitHib Action.
	//
	// +required
	RegistryInfoConfigMapRef ObjectReference `json:"registryInfoConfigMapRef,omitempty"`
}

type GithubRepoStatus struct {
	xpv1.ConditionedStatus `json:",inline"`
}
