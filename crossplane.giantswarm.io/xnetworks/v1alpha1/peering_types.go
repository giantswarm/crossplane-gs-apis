package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=pcx
// +crossbuilder:generate:xrd:claimNames:kind=VpcPeeringClaim,plural=vpcpeeringclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=vpcpeering
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=vpcpeering
type Peering struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   PeeringSpec   `json:"spec"`
	Status PeeringStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type PeeringList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []Peering `json:"items"`
}

type PeeringSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Contains details about the VPC peering connection
	PeeringParameters `json:",inline"`
}

type PeeringStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// The ID of the VPC peering connection.
	//
	// +optional
	PeeringConnectionId string `json:"peeringConnectionId,omitempty"`
}

type PeeringParameters struct {
	// Determines if the VPC peering should be enabled
	//
	// +optional
	// +default=true
	Enabled bool `json:"enabled"`

	// Details of the local VPC
	LocalVpcDetails VpcDetails `json:"localVpcDetails"`

	// Details of the peer VPC
	PeerVpcDetails VpcDetails `json:"peerVpcDetails"`

	// Tags to apply to the VPC peering connection
	//
	// +optional
	Tags map[string]string `json:"tags,omitempty"`
}

// Repository type metadata.
var (
	PeeringKind      = "Peering"
	PeeringGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  PeeringKind,
	}.String()
	PeeringKindAPIVersion   = PeeringKind + "." + GroupVersion.String()
	PeeringGroupVersionKind = GroupVersion.WithKind(PeeringKind)
)
