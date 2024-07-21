package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

type SubnetSetSubnet struct {

	// CidrBlock is a the CIDR block to use for this subnets.
	// +required
	// +kubebuilder:validation:Required
	CidrBlock Cidr `json:"cidrBlock"`

	// Zone is the availability zone to create the subnet in.
	// +required
	// +kubebuilder:validation:Required
	Zone string `json:"zone"`
}

type SubnetSetSubnets struct {

	// SubnetA is the subnet in availability zone A.
	// +required
	// +kubebuilder:validation:Required
	SubnetA SubnetSetSubnet `json:"a"`

	// SubnetB is the subnet in availability zone B.
	// +required
	// +kubebuilder:validation:Required
	SubnetB SubnetSetSubnet `json:"b"`

	// SubnetC is the subnet in availability zone C.
	// +required
	// +kubebuilder:validation:Required
	SubnetC SubnetSetSubnet `json:"c"`
}

type TagSet struct {

	// All is a map of tags to apply to all resources in the subnetset.
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=50
	All map[string]string `json:"all,omitempty"`

	// Subnet is a map of tags to apply only to the subnet resources
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=50
	Subnet map[string]string `json:"subnet,omitempty"`
}

type VpcId string

type SubnetSetParameters struct {
	// AppIndex is the index of the application that the subnet is being created for.
	//
	// This is used for complex applications that require multiple subnet groupsr
	// Normally leave this on the default.
	// +optional
	// +default=""
	AppIndex string `json:"appIndex,omitempty"`

	// Region is the region you'd like the VPC to be created in.
	// +immutable
	// +required
	// +kubebuilder:validation:Pattern="^[a-z]{2}-[a-z]+-[0-9]$"
	// +kubebuilder:validation:Required
	Region string `json:"region"`

	// Tags is a set of tags to apply to resources in the subnetset
	// +optional
	// +structType=atomic
	Tags TagSet `json:"tags,omitempty"`

	// Type is the type of VPC Subnet to create.
	// +optional
	// +kubebuilder:validation:Enum=public;private
	// +kubebuilder:default=public
	// +kubebuilder:validation:Required
	Type string `json:"type,omitempty"`

	// Subnets is a map of availability zones and subnet cidr blocks.
	// +required
	Subnets map[string]*string `json:"subnets"`

	// VpcId is the unique identifier for the VPC.
	// +immutable
	// +required
	VpcId VpcId `json:"vpcId"`
}

type SubnetStatusId string

type SubnetSetStatusSubnet struct {

	// SubnetA is the subnet ID in availability zone A.
	// +optional
	SubnetA SubnetStatusId `json:"a,omitempty"`

	// SubnetAName is the name of the subnet in availability zone A.
	// +optional
	SubnetAName string `json:"aName,omitempty"`

	// SubnetB is subnet ID in availability zone B.
	// +optional
	SubnetB SubnetStatusId `json:"b,omitempty"`

	// SubnetBName is the name of the subnet in availability zone B.
	// +optional
	SubnetBName string `json:"bName,omitempty"`

	// SubnetC is the subnet ID in availability zone C.
	// +optional
	SubnetC SubnetStatusId `json:"c,omitempty"`

	// SubnetCName is the name of the subnet in availability zone C.
	// +optional
	SubnetCName string `json:"cName,omitempty"`
}

type SubnetSetStatusRouteTable struct {

	// RouteTableA is the route table ID for availability zone A.
	// +optional
	RouteTableA string `json:"a,omitempty"`

	// RouteTableAName is the name of the route table in availability zone A.
	// +optional
	RouteTableAName string `json:"aName,omitempty"`

	// RouteTableB is the route table ID for availability zone B.
	// +optional
	RouteTableB string `json:"b,omitempty"`

	// RouteTableBName is the name of the route table in availability zone B.
	// +optional
	RouteTableBName string `json:"bName,omitempty"`

	// RouteTableC is the route table ID for availability zone C.
	// +optional
	RouteTableC string `json:"c,omitempty"`

	// RouteTableCName is the name of the route table in availability zone C.
	// +optional
	RouteTableCName string `json:"cName,omitempty"`
}

type SubnetSetStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// VpcID is the unique identifier for the VPC.
	// +required
	VpcID string `json:"vpcId,omitempty"`

	// Subnets is a map of subnets discovered by the composite.
	// +optional
	// +structType=atomic
	Subnets map[string]*string `json:"subnets,omitempty"`

	// RouteTables is a map of route tables discovered by the composite.
	// +optional
	// +structType=atomic
	RouteTables map[string]*string `json:"routeTables,omitempty"`
}

type SubnetSetSpec struct {
	xpv1.ResourceSpec   `json:",inline"`
	SubnetSetParameters `json:",inline"`
}

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=sn
// +crossbuilder:generate:xrd:claimNames:kind=SubnetSetClaim,plural=subnetsetclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=subnetset
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=subnetset
type SubnetSet struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   SubnetSetSpec   `json:"spec"`
	Status SubnetSetStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type SubnetSetList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []SubnetSet `json:"items"`
}

// Repository type metadata.
var (
	SubnetSetKind             = "SubnetSet"
	SubnetSetGroupKind        = schema.GroupKind{Group: XRDGroup, Kind: SubnetSetKind}.String()
	SubnetSetKindAPIVersion   = SubnetSetKind + "." + GroupVersion.String()
	SubnetSetGroupVersionKind = GroupVersion.WithKind(SubnetSetKind)
)
