package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	ResourceAccessManagerKind      = "ResourceAccessManager"
	ResourceAccessManagerGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  ResourceAccessManagerKind,
	}.String()
	ResourceAccessManagerKindAPIVersion   = ResourceAccessManagerKind + "." + GroupVersion.String()
	ResourceAccessManagerGroupVersionKind = GroupVersion.WithKind(ResourceAccessManagerKind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=ram
// +crossbuilder:generate:xrd:claimNames:kind=ResourceAccessManagerClaim,plural=resourceaccessmanagerclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=resource-access-manager
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=resource-access-manager
type ResourceAccessManager struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   ResourceAccessManagerSpec   `json:"spec"`
	Status ResourceAccessManagerStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type ResourceAccessManagerList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []ResourceAccessManager `json:"items"`
}

type ResourceAccessManagerSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// The name of the resource access manager.
	//
	// +required
	Name string `json:"name"`

	// The region in which the resource should be created.
	//
	// +required
	Region string `json:"region"`

	// The tags to associate with the resource access manager.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`

	RamParameters `json:",inline"`
}

type RamParameters struct {
	// If external principals are allowed to access the resource access manager.
	//
	// +optional
	// +default=false
	AllowExternalPrincipals *bool `json:"allowExternalPrincipals,omitempty"`

	// A list of principals to associate with the resource access manager.
	//
	// +optional
	Principals []*Principal `json:"principals,omitempty"`

	// A list of resources to associate with the resource access manager.
	//
	// +optional
	Resources []*Resource `json:"resources,omitempty"`

	// The permissions to associate with the resource access manager.
	//
	// +optional
	Permissions []*Permission `json:"permissions,omitempty"`
}

type ResourceAccessManagerStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// The ARN of the resource access manager.
	//
	// +optional
	Arn string `json:"arn,omitempty"`

	// The ID of the resource access manager.
	//
	// +optional
	Id string `json:"id,omitempty"`

	// Is the resource access manager ready
	//
	// +optional
	Ready bool `json:"ready,omitempty"`
}

type Principal struct {
	// The principal to associate with the resource access manager.
	//
	// Possible values are AWS Account ID, AWS Organization ID, or AWS organizations.
	//
	// +required
	Principal string `json:"principal"`

	// If this is a cross-org principal.
	//
	// +optional
	// +default=false
	CrossOrg *bool `json:"crossOrg,omitempty"`

	// Provider config for accepting the share
	//
	// +optional
	ProviderConfigRef xpv1.Reference `json:"providerConfigRef,omitempty"`
}

type Resource string

type Permission string
