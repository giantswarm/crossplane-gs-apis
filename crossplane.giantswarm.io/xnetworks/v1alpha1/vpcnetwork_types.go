package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// Cidr is a string type that represents a CIDR block.
// +kubebuilder:validation:Pattern="^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$"
// +kubebuilder:validation:Type=string
type Cidr string

type Subnets struct {
	// CidrBlocks is a list of CIDR blocks for the subnets.
	// The number of blocks defined should be twice the length of the
	// availability zones with the first half being assigned to public
	// subnets and the second half being assigned to private subnets.
	//
	// +kubebuilder:validation:MinItems=6
	// +kubebuilder:validation:MaxItems=6
	// +kubebuilder:validation:Required
	// +listType=atomic
	CidrBlocks []Cidr `json:"cidrBlocks"`

	// Zones is a list of availability zones to create subnets in.
	// This should be defined as a list of single character strings. (e.g. ["a", "b", "c"])
	//
	// +kubebuilder:validation:MinItems=3
	// +kubebuilder:validation:MaxItems=3
	// +kubebuilder:validation:Required
	Zones []string `json:"zones"`

	// Tags is a map of additional tags to assign to the subnets.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`
}

type VpcTags struct {
	// Common tags to assign to all resources. This is 5 less than max tags to allow for
	// additional tags to be added to the subnets.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=45
	Common map[string]string `json:"common,omitempty"`

	// Tags to assign to the public subnets. These are merged with the common tags.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=5
	PublicSubnetTags map[string]string `json:"publicSubnetTags,omitempty"`

	// Tags to assign to the private subnets. These are merged with the common tags.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=5
	PrivateSubnetTags map[string]string `json:"privateSubnetTags,omitempty"`
}

type VpcNetworkParameters struct {

	// Region is the region you'd like the VPC to be created in.
	// +immutable
	// +required
	// +kubebuilder:validation:Pattern="^[a-z]{2}-[a-z]+-[0-9]$"
	// +kubebuilder:validation:Required
	Region string `json:"region"`

	// Tags is a map of tags to assign to the VPC.
	// +optional
	// + structType=atomic
	Tags VpcTags `json:"tags,omitempty"`

	// Subnets is a map of availability zones and subnet cidr blocks.
	// +required
	Subnets Subnets `json:"subnets"`

	// VPCCidr is the primary CIDR block for the VPC.
	//
	// +immutable
	// +required
	// +kubebuilder:validation:Required
	VpcCidr Cidr `json:"vpcCidr"`
}

type VpcNetworkStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// Contains details of the created VPC
	// +structType=atomic
	nd.Vpc `json:",omitempty"`
}

type VpcNetworkSpec struct {
	xpv1.ResourceSpec    `json:",inline"`
	VpcNetworkParameters `json:",inline"`
}

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:printcolumn:name="Region",type=string,JSONPath=`.spec.region`
// +kubebuilder:printcolumn:name="VpcID",type=string,JSONPath=`.status.vpcID`
// +kubebuilder:resource:shortName=vpc
// +crossbuilder:generate:xrd:claimNames:kind=VpcNetworkClaim,plural=vpcnetworkclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=vpc-network
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=vpc-network
type VpcNetwork struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   VpcNetworkSpec   `json:"spec"`
	Status VpcNetworkStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type VpcNetworkList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []VpcNetwork `json:"items"`
}

// Repository type metadata.
var (
	VpcNetworkKind             = "VpcNetwork"
	VpcNetworkGroupKind        = schema.GroupKind{Group: XRDGroup, Kind: VpcNetworkKind}.String()
	VpcNetworkKindAPIVersion   = VpcNetworkKind + "." + GroupVersion.String()
	VpcNetworkGroupVersionKind = GroupVersion.WithKind(VpcNetworkKind)
)
