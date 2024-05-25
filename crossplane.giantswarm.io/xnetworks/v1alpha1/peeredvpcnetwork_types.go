package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:printcolumn:name="Region",type=string,JSONPath=`.spec.region`
// +kubebuilder:printcolumn:name="VpcID",type=string,JSONPath=`.status.vpcID`
// +kubebuilder:resource:shortName=pvpc
// +crossbuilder:generate:xrd:claimNames:kind=PeeredVpcNetworkClaim,plural=peeredvpcnetworkclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=peered-vpc-network
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=peered-vpc-network
type PeeredVpcNetwork struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   PeeredVpcNetworkSpec   `json:"spec"`
	Status PeeredVpcNetworkStatus `json:"status,omitempty"`
}

type PeeredVpcNetworkSpec struct {
	xpv1.ResourceSpec          `json:",inline"`
	PeeredVpcNetworkParameters `json:",inline"`
}

type PeeredVpcNetworkParameters struct {

	// Region is the region in which the VPC will be created.
	Region string `json:"region"`

	// CIDR is the CIDR block for the VPC.
	CIDR string `json:"cidr"`

	// PeeredSubnets defines how many public and private subnet sets to create.
	PeeredSubnets PeeredSubnets `json:"subnets"`

	// Tags is a map of additional tags to assign to the VPC.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`

	// Peering is the VPC to peer with.
	Peering VpcPeer `json:"peering"`
}

type VpcPeer struct {

	// VpcName specifies the name of the VPC to peer with.
	VpcName string `json:"vpcName"`

	// Region specifies the region the VPC is found in
	Region string `json:"region"`

	// Disabled specifies if the peering connection should be disabled.
	Disabled bool `json:"disabled"`
}

type PeeredSubnets struct {
	// PublicSets defines how many public subnet-sets to create with each set
	// spanning 3 availability zones
	//
	// +required
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=3
	PublicSets int `json:"publicSets"`

	// PrivateSets defines how many private subnet-sets to create with each set
	// spanning 3 availability zones
	//
	// +required
	// +kubebuilder:validation:Minimum=1
	// +kubebuilder:validation:Maximum=3
	PrivateSets int `json:"privateSets"`

	// Bits is a list of subnet bits to use for the subnet CIDR blocks. Basically
	// how to split the VPC CIDR. Each bit represents the CIDR block size for a
	// single availability zone. The number of bits must match the number of
	// availability zones in the region.
	//
	// For example, if the VPC CIDR is 192.168.1.0/24 and the region has 3
	// availability zones, the bits could be [2, 2, 2] which would result in
	// 3 subnets with CIDR blocks allowing for 64 hosts each.
	//
	// For a more advanced configuration you might splut this into 1 public and
	// 3 private subnet sets with the following bits:
	//
	// [
	//   3, 3, 3, # Public subnet,  each on /27 giving 30 hosts x 3
	//   4, 4, 4, # Private subnet, each on /28 giving 14 hosts x 3
	//   4, 4, 4, # Private subnet, each on /28 giving 14 hosts x 3
	//   4, 4, 4  # Private subnet, each on /28 giving 14 hosts x 3
	// ]
	//
	// +required
	// +kubebuilder:validation:MinItems=1
	// +kubebuilder:validation:MaxItems=3
	Bits []int `json:"bits"`

	// AvailabilityZones is a list of availability zones in the region. The number
	// of availability zones must match the number of bits x the number of subnetsets
	// (public + private). The VPC Cidr must be big enough to encompass all the
	// subnet CIDR blocks.
	//
	// +required
	// +kubebuilder:validation:MinItems=3
	// +kubebuilder:validation:MaxItems=3
	AvailabilityZones []string `json:"availabilityZones"`

	// Function defines the function to use to calculate the CIDR blocks for the
	// subnets. The default is "cidrsubnets" which will split the VPC CIDR into
	// equal parts based on the number of bits provided. `cidrsubnets` is the only
	// function being made available as part of this XRD and as it's defaulted
	// it can be hidden from the user. The function input expects a path though
	// so this has to exist but isn't expected to be defined on the claim.
	//
	// +optional
	// +kubebuilder:validation:Type=enum
	// +kubebuilder:validation:Enum=cidrsubnets
	// +kubebuilder:default=cidrsubnets
	Function string `json:"function"`
}

type PeeredVpcNetworkStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// Contains details of the created VPC
	// +structType=atomic
	nd.Vpc `json:",omitempty"`

	// Contains the CIDR blocks output by function-cidr
	// +listType=atomic
	CalculatedCidrs []string `json:"calculatedCidrs,omitempty"`
	SubnetBits      []int    `json:"subnetBits,omitempty"`
}

// +kubebuilder:object:root=true
type PeeredVpcNetworkList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []PeeredVpcNetwork `json:"items"`
}

// Repository type metadata.
var (
	PeeredVpcNetworkKind             = "PeeredVpcNetwork"
	PeeredVpcNetworkGroupKind        = schema.GroupKind{Group: XRDGroup, Kind: PeeredVpcNetworkKind}.String()
	PeeredVpcNetworkKindAPIVersion   = PeeredVpcNetworkKind + "." + GroupVersion.String()
	PeeredVpcNetworkGroupVersionKind = GroupVersion.WithKind(PeeredVpcNetworkKind)
)
