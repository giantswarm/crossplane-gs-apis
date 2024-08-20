package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	ManagedPrefixListKind      = "ManagedPrefixList"
	ManagedPrefixListGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  ManagedPrefixListKind,
	}.String()
	ManagedPrefixListKindAPIVersion   = ManagedPrefixListKind + "." + GroupVersion.String()
	ManagedPrefixListGroupVersionKind = GroupVersion.WithKind(ManagedPrefixListKind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=mpl
// +crossbuilder:generate:xrd:claimNames:kind=ManagedPrefixListClaim,plural=managedprefixlistclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=managed-prefix-list
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=managed-prefix-list
type ManagedPrefixList struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   ManagedPrefixListSpec   `json:"spec"`
	Status ManagedPrefixListStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type ManagedPrefixListList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []ManagedPrefixList `json:"items"`
}

type ManagedPrefixListSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	ManagedPrefixListParameters `json:",inline"`
}

type ManagedPrefixListStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// The ARN of the prefix list.
	//
	// +optional
	Arn *string `json:"arn,omitempty"`

	// The ID of the prefix list.
	//
	// +optional
	ID *string `json:"id,omitempty"`

	// Is the prefix list ready
	//
	// +optional
	Ready bool `json:"ready,omitempty"`
}

type ManagedPrefixListParameters struct {
	ManagedPrefixListSubParameters `json:",inline"`

	// The name of the prefix list.
	//
	// +required
	Name *string `json:"name,omitempty"`

	// The region for the prefix list.
	//
	// +required
	Region *string `json:"region,omitempty"`

	// The tags for the prefix list.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`
}

// ManagedPrefixListSubParameters
type ManagedPrefixListSubParameters struct {
	// The address family (ipv4 or ipv6) for the prefix list.
	//
	// +optional
	// +kubebuilder:validation:Enum=IPv4;IPv6
	// +kubebuilder:default=IPv4
	AddressFamily *string `json:"addressFamily,omitempty"`

	// The prefix list entries.
	//
	// +optional
	Entries []ManagedPrefixListEntry `json:"entries,omitempty"`

	// The maximum number of entries for the prefix list.
	//
	// +optional
	MaxEntries *int64 `json:"maxEntries,omitempty"`
}

type ManagedPrefixListEntry struct {
	// The CIDR block for the prefix list entry.
	//
	// +optional
	Cidr *Cidr `json:"cidr,omitempty"`

	// The description for the prefix list entry.
	//
	// +optional
	Description *string `json:"description,omitempty"`
}
