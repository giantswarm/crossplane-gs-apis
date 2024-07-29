package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
)

// AvailabilityZone is a string type that represents the availability zone
// for a subnet.
//
// +kubebuilder:validation:Type=string
// +kubebuilder:validation:Pattern="^[a-z]{2}-[a-z]+-[0-9]+[a-z]$"
type AvailabilityZone string

// Cidr is a string type that represents a CIDR block.
//
// +kubebuilder:validation:Pattern="^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$"
// +kubebuilder:validation:Type=string
type Cidr string

// A single character representation of the short name of an availability zone.
// For example, "a" for "eu-west-1a".
//
// +kubebuilder:validation:Type=string
// +kubebuilder:validation:Pattern="^[a-z]$"
type ShortAz string

// SubnetId is a string type that represents the unique identifier for a subnet.
//
// +kubebuilder:validation:Type=string
// +kubebuilder:validation:Pattern="^subnet-[a-z0-9]{8,17}$"
type SubnetId string

// RouteTableId is a string type that represents the unique identifier for a
// route table.
//
// +kubebuilder:validation:Type=string
// +kubebuilder:validation:Pattern="^rtb-[a-z0-9]{8,17}$"
type RouteTableId string

// VpcId is a string type that represents the unique identifier for a VPC.
//
// +kubebuilder:validation:Type=string
// +kubebuilder:validation:Pattern="^vpc-[a-z0-9]{8,17}$"
type VpcId string

// VpcDetails contains the details of a VPC.
type VpcDetails struct {
	// Name of the VPC.
	//
	// +required
	Name string `json:"name"`

	// The ID of the VPC.
	//
	// +required
	VpcId VpcId `json:"vpcId"`

	// The CIDR blocks for the VPC.
	//
	// +required
	CidrBlock []Cidr `json:"cidrBlocks"`

	// ProviderConfigRef is a reference to a provider configuration
	// for managing connections to this vpc
	//
	// +optional
	ProviderConfigRef *xpv1.Reference `json:"providerConfigRef,omitempty"`

	// Region is the region in which the VPC is located.
	//
	// Required if local vpc
	//
	// +optional
	Region string `json:"region"`

	// The route table ids in the VPC.
	//
	// +required
	RouteTableIds []RouteTableId `json:"routeTableIds"`
}
