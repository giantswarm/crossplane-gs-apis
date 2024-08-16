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
// +kubebuilder:resource:shortName=mpl
// +crossbuilder:generate:xrd:claimNames:kind=ResourceAccessManagerClaim,plural=resourceaccessmanagerclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=resource-access-manager
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=resouce-access-manager
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
	RamParameters           `json:",inline"`
	AllowExternalPrincipals *bool `json:"allowExternalPrincipals,omitempty"`

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
}

type RamParameters struct {
	// A list of principals to associate with the resource access manager.
	//
	// +optional
	Principals []*Principal `json:"principles,omitempty"`

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
}

type Principal struct {
	// The principal to associate with the resource access manager.
	//
	// Possible values are AWS Account ID, AWS Organization ID, or AWS organizations.
	//
	// +required
	Principal string `json:"principal"`

	// Provider config for accepting the share
	//
	// +optional
	ProviderConfig xpv1.Reference `json:"providerConfig,omitempty"`
}

type Resource string

type Permission string
