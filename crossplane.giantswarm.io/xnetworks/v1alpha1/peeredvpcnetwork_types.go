package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	fncdr "github.com/mproffitt/function-cidr/input/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// PeerVpcNetworkSpec defines the desired state of PeerVpcNetwork
//
// This is a more advanced composition that uses KCL language to calculate the
// overall structure of the VPC and subnets, utilising dynamic calculation for
// the components of the VPC.
//
// A claim made against this composition will result in the creation of a VPC
// with a number of subnets grouped into sets of 3 availability zones.
//
// If VPC Peering is enabled, the VPC will be peered with the VPCs specified in
// the claim under the `spec.peering.remoteVpcs` field.
//
// Up to 5 CIDR ranges can be specified and these are done via the
// `spec.subnetsets.cidrs` field, where the first entry in the list is the
// default VPC CIDR and all subsequent entries are attached as additional
// VPC CIDRs.
//
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
	xpv1.ResourceSpec `json:",inline"`

	// AvailabilityZones is a list of availability zones in the region. The
	// number of availability zones must match the number of bits x the number
	// of subnetsets (public + private). The VPC Cidr must be big enough to
	// encompass all the subnet CIDR blocks.
	//
	// +required
	// +kubebuilder:validation:MinItems=3
	// +kubebuilder:validation:MaxItems=3
	AvailabilityZones []string `json:"availabilityZones"`

	// PeeredVpcNetworkParameters defines the parameters for creating a VPC with
	// the option of peered subnets.
	//
	// +required
	PeeredVpcNetworkParameters `json:",inline"`

	// Region is the region in which the VPC will be created.
	//
	// +required
	Region string `json:"region"`
}

// PeeredVpcTags defines the tags to apply to the VPC and subnets.
type PeeredVpcTags struct {
	// common tags apoplied to all resources
	//
	// +optional
	// +mapType=granular
	Common map[string]string `json:"common,omitempty"`

	// Subnet tags to apply to all subnetsets
	//
	// +optional
	// +mapType=granular
	Subnet map[string]string `json:"subnet,omitempty"`

	// Cluster tags to apply subnets for autodiscovery of load balancers
	//
	// +optional
	// +mapType=granular
	Cluster map[string]string `json:"cluster,omitempty"`
}

// PeeredVpcNetworkParameters defines the parameters for creating a VPC with
// the option of peered subnets.
type PeeredVpcNetworkParameters struct {
	// PeeredSubnets defines how many public and private subnet sets to create.
	//
	// +required
	PeeredSubnets PeeredSubnets `json:"subnetsets"`

	// Tags is a map of additional tags to assign to the VPC.
	//
	// +optional
	// +structType=granular
	Tags PeeredVpcTags `json:"tags,omitempty"`

	// Peering is the VPC to peer with.
	//
	// +required
	Peering VpcPeering `json:"peering"`
}

// VpcPeering defines the parameters for VPC peering.
//
// If enabled, the VPC will be peered with the VPCs specified in the
// `remoteVpcs` field.
type VpcPeering struct {
	// AllowPublic specifies if the VPC peering connections should be allowed to
	// be linked to the public subnets
	// Defaults to false
	//
	// +optional
	// +default=false
	AllowPublic bool `json:"allowPublic"`
	// Enabled specifies if the VPC peering connections should be enabled for
	// this VPC.
	// Defaults to false
	//
	// +optional
	// +default=false
	Enabled bool `json:"enabled"`

	// GroupBy specifies the key to group the remote subnets by
	//
	// +optional
	GroupBy string `json:"groupBy"`

	// RemoteVpcs is a list of VPCs to peer with.
	//
	// +listType=atomic
	// +kubebuilder:validation:MaxItems=125
	// +optional
	RemoteVpcs []VpcPeer `json:"remoteVpcs"`
}

type SetExclusion struct {
	// public subnets to exclude from peering
	//
	// +optional
	// +listType=atomic
	Public []int `json:"public"`

	// private subnets to exclude from peering
	//
	// +optional
	// +listType=atomic
	Private []int `json:"private"`
}

// VpcPeer defines the parameters for peering with a VPC.
type VpcPeer struct {
	// Disabled specifies if the peering connection should be disabled.
	// Defaults to true
	//
	// +optional
	// +default=true
	AllowPublic bool `json:"allowPublic"`

	// MyExcludedSubnetsets specifies the indexes of subnetsets for this VPC to
	// exclude from routing to the peering connection
	//
	// +optional
	MyExcludedSubnetSets SetExclusion `json:"excludeFromPeering,omitempty"`

	// Name specifies the name of the VPC to peer with.
	//
	// +required
	Name string `json:"name"`

	// ProviderConfigRef specifies the provider config to use for the peering
	// connection.
	//
	// +optional
	ProviderConfigRef string `json:"providerConfigRef"`

	// Region specifies the region the VPC is found in.
	//
	// If not defined, the region of the VPC will be assumed to be the same as
	// the region of the peered VPC.
	//
	// +optional
	Region string `json:"region"`

	// TheirExcludedSubnetsets specifies the indexes of subnetsets for the remote
	// VPC to exclude from routing to the peering connection. If emmpty, all
	// subnetsets will be included by default
	//
	// +optional
	TheirExcludedSubnetSets []SetExclusion `json:"theirExcludeFromPeering,omitempty"`
}

// PeeredSubnetSet defines the parameters for creating a set of subnets with the
// same mask.
type PeeredSubnetSet struct {
	// Prefix is the CIDR prefix to use for the subnet set
	//
	// +required
	// +immutable
	Prefix Cidr `json:"prefix"`

	// Public is the number of public subnets to create in this set
	//
	// +required
	Public PeeredSubnetBuilder `json:"public"`

	// Private is the number of private subnets to create in this set
	//
	// +required
	Private PeeredSubnetBuilder `json:"private"`
}

// PeeredSubnetBuilder defines the parameters for creating a set of subnets
// with the same mask.
//
// The mask is the destination CIDR range to use and the count is the number of
// subnets to create with this mask. It is your responsibility to ensure that
// the VPC Cidr to be used as a prefix is large enough to encompass all the
// subnets created, if not an error will be returned on the staus of the XR
//
// The offset is the number of bits to offset the subnet mask by. This is useful
// when you may want to create only private subnets, leaving public to be
// created at a later time, or just want to control how the subnets are created.
// If no offset is specified, the subnets will be created from the start of the
// cidr range
type PeeredSubnetBuilder struct {
	// Count is the number of subnet sets to create with this mask
	//
	// +optional
	// +default=0
	Count int `json:"count"`

	// Determines which subnet set in this range to use for kubernetes load
	// balancers. -1 means no load balancer tag is defined on this group
	//
	// +optional
	// +default=-1
	LoadBalancerIndex int `json:"lbSetIndex"`

	// Mask is the CIDR mask to use for the subnet set
	//
	// +required
	// +immutable
	Mask string `json:"mask"`

	// Offset is the number of bits to offset the subnet mask by
	//
	// +optional
	// +default=0
	Offset int `json:"offset"`
}

// PeeredSubnets defines the parameters for creating a set of subnets with the
// same mask.
type PeeredSubnets struct {
	// Cidrs is a list of PeeredSubnetSets to create in the VPC
	//
	// Each PeeredSubnetSet will create 1 subnet
	//
	// +required
	// +kubebuilder:validation:MinItems=1
	// +kubebuilder:validation:MaxItems=5
	// +listType=atomic
	Cidrs []PeeredSubnetSet `json:"cidrs"`

	// Function defines the function to use to calculate the CIDR blocks for the
	// subnets. The default is "multiprefixloop" which will split multiple CIDRs
	// into equal parts based on the number of bits provided.
	// `multiprefixloop` is the only function being made available as part of
	// this XRD and as it's defaulted it can be hidden from the user. The
	// function input expects a path though so this has to exist but isn't
	// expected to be defined on the claim.
	//
	// +optional
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Enum=multiprefixloop
	// +kubebuilder:default=multiprefixloop
	Function string `json:"function"`
}

type PeeredVpcNetworkStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// Contains the CIDR blocks output by function-cidr
	//
	// +optional
	// +mapType=atomic
	CalculatedCidrs map[string][]string `json:"calculatedCidrs"`

	// Contains the subnet bits output by function-kcl-subnet-bits
	//
	// +listType=atomic
	// +optional
	SubnetBits []fncdr.MultiPrefix `json:"subnetBits"`

	// Vpcs contains details of both the peered VPCs and the current local VPC
	// The current VPC can be found at the `self` key
	//
	// +optional
	// +mapType=granular
	Vpcs map[string]nd.Vpc `json:"vpcs,omitempty"`
}

// +kubebuilder:object:root=true
type PeeredVpcNetworkList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []PeeredVpcNetwork `json:"items"`
}

// Repository type metadata.
var (
	PeeredVpcNetworkKind      = "PeeredVpcNetwork"
	PeeredVpcNetworkGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  PeeredVpcNetworkKind,
	}.String()
	PeeredVpcNetworkKindAPIVersion   = PeeredVpcNetworkKind + "." + GroupVersion.String()
	PeeredVpcNetworkGroupVersionKind = GroupVersion.WithKind(PeeredVpcNetworkKind)
)
