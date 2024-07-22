package v1alpha1

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
