package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// TagSet is a set of tags to apply to resources in the subnetset.
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

type SubnetSetParameters struct {
	// AppIndex is the index of the application that the subnet is being created for.
	//
	// This is used for complex applications that require multiple subnet groups
	// Normally leave this on the default.
	//
	// +optional
	// +default=""
	AppIndex string `json:"appIndex,omitempty"`

	// Region is the region you'd like the VPC to be created in.
	//
	// +immutable
	// +required
	// +kubebuilder:validation:Pattern="^[a-z]{2}-[a-z]+-[0-9]$"
	// +kubebuilder:validation:Required
	Region string `json:"region"`

	// Subnets is a map of availability zones and subnet cidr blocks.
	//
	// +required
	Subnets map[ShortAz]*Cidr `json:"subnets"`

	// Tags is a set of tags to apply to resources in the subnetset
	//
	// +optional
	// +structType=atomic
	Tags TagSet `json:"tags,omitempty"`

	// Type is the type of VPC Subnet to create.
	//
	// +optional
	// +kubebuilder:validation:Enum=public;private
	// +kubebuilder:default=public
	// +kubebuilder:validation:Required
	Type string `json:"type,omitempty"`

	// VpcId is the unique identifier for the VPC.
	//
	// +immutable
	// +required
	VpcId VpcId `json:"vpcId"`
}

type SubnetSetStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// VpcID is the unique identifier for the VPC.
	//
	// +required
	VpcID VpcId `json:"vpcId,omitempty"`

	// Subnets is a map of subnets discovered by the composite.
	//
	// +optional
	// +structType=atomic
	Subnets map[AvailabilityZone]*SubnetId `json:"subnets,omitempty"`

	// RouteTables is a map of route tables discovered by the composite.
	//
	// +optional
	// +structType=atomic
	RouteTables map[AvailabilityZone]*RouteTableId `json:"routeTables,omitempty"`
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
