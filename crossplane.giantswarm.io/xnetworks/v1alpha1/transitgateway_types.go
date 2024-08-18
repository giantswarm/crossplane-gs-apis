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
// +kubebuilder:resource:shortName=tgw
// +crossbuilder:generate:xrd:claimNames:kind=TransitGatewayClaim,plural=transitgatewayclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=transitgateway
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=transitgateway
type TransitGateway struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   TransitGatewaySpec   `json:"spec"`
	Status TransitGatewayStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type TransitGatewayList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []TransitGateway `json:"items"`
}

type TransitGatewaySpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Contains details about the local VPC (Where the TGW will be built)
	//
	// +optional
	LocalVpc TransitGatewayVpc `json:"localVpc,omitempty"`

	// Contains details about the remote VPCs
	//
	// +optional
	RemoteVpcs []TransitGatewayVpcWithProviderConfig `json:"remoteVpcs,omitempty"`

	// Peers defines other transit gateways that this transit gateway
	// should peer with
	//
	// +optional
	Peers []TransitGatewayPeer `json:"peers,omitempty"`

	// TransitGatewayParameters defines the desired state of TransitGateway
	TransitGatewayParameters `json:",inline"`
}

type TransitGatewayParameters struct {
	// Amazon side ASN. Private autonomous system number (ASN) for
	// the Amazon side of a BGP session.
	//
	// +optional
	AmazonSideAsn int64 `json:"amazonSideAsn,omitempty"`

	// Appliance mode support. Indicates whether appliance mode support is enabled.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=disable
	ApplianceModeSupport string `json:"applianceModeSupport,omitempty"`

	// Auto accept shared attachments. Indicates whether there is automatic
	// acceptance of attachment requests.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=enable
	AutoAcceptSharedAttachments string `json:"autoAcceptSharedAttachments,omitempty"`

	// Create the policy table.
	//
	// +optional
	// +default=false
	CreatePolicyTable bool `json:"createPolicyTable,omitempty"`

	// Default route table association. Indicates whether resource attachments
	// are automatically associated with the default association route table.
	//
	// +optional
	// +default=true
	DefaultRouteTableAssociation bool `json:"defaultRouteTableAssociation,omitempty"`

	// Default route table propagation. Indicates whether resource attachments
	// automatically propagate routes to the default propagation route table.
	//
	// +optional
	// +default=true
	DefaultRouteTablePropagation bool `json:"defaultRouteTablePropagation,omitempty"`

	// Dns support. Indicates whether DNS support is enabled.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=enable
	DnsSupport string `json:"dnsSupport,omitempty"`

	// If IPv6 support is enabled for the transit gateway.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=disable
	Ipv6Support string `json:"ipv6Support,omitempty"`

	// Multicast support. Indicates whether multicast is enabled on the transit gateway.
	//
	// Currently unused in this composition
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=disable
	MulticastSupport string `json:"multicastSupport,omitempty"`

	// Resource Access Management (RAM)
	//
	// +optional
	RAM RAM `json:"ram,omitempty"`

	// TransitGatewayDefaultRouteTableAssociation. Indicates whether resource
	// attachments are automatically associated with the default association route table.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=disable
	TransitGatewayDefaultRouteTableAssociation string `json:"transitGatewayDefaultRouteTableAssociation,omitempty"`

	// TransitGatewayDefaultRouteTablePropagation. Indicates whether resource
	// attachments automatically propagate routes to the default propagation route table.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=disable
	TransitGatewayDefaultRouteTablePropagation string `json:"transitGatewayDefaultRouteTablePropagation,omitempty"`

	// The tags for the transit gateway.
	//
	// +optional
	// +mapType=atomic
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`

	// Vpn ecmp support. Indicates whether Equal Cost Multipath Protocol support is enabled.
	//
	// +optional
	// +kube:validation:Enum=disable;enable
	// +default=enable
	VpnEcmpSupport string `json:"vpnEcmpSupport,omitempty"`
}

type TransitGatewayStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// map of local attachments
	//
	// +optional
	LocalAttachmentIds map[string]string `json:"localAttachmentIds,omitempty"`

	// Is the transit gateway ready
	//
	// +optional
	Ready bool `json:"ready,omitempty"`

	// map of remote attachments
	//
	// +optional
	RemoteAttachmentIds map[string]string `json:"remoteAttachmentIds,omitempty"`

	// The ARN of the Transit Gateway.
	//
	// +optional
	TgwArn string `json:"tgwArn,omitempty"`

	// The ID of the Transit Gateway.
	//
	// +optional
	TgwId string `json:"tgwId,omitempty"`

	// The ID of the route table associated with the Transit Gateway.
	//
	// +optional
	TgwRouteTableId string `json:"tgwRouteTableId,omitempty"`

	// If Resource Access Management is enabled, the ID of the RAM share
	//
	// +optional
	RamShareId string `json:"ramShareId,omitempty"`

	// If Resource Access Management is enabled, the ARN of the RAM share
	//
	// +optional
	RamShareArn string `json:"ramShareArn,omitempty"`
}

type TransitGatewayPeer struct {
	// The Account ID this VPC is associated with
	//
	// +optional
	AccountId string `json:"accountId"`

	// Is Dynamic routing support enabled on this peer
	//
	// +optional
	// +default=false
	DynamicRouting bool `json:"dynamicRouting"`

	// The ID of the gateway to peer with
	//
	// +required
	Id string `json:"id"`

	// The ID of the remote route table
	//
	// +required
	RouteTableId string `json:"routeTableId"`

	// The name of the peer
	//
	// +required
	Name string `json:"name"`

	// ManagedPrefixList contains CIDRs for networks that can be traversed
	// via this transit gateway.
	//
	// +optional
	PrefixLists []PrefixList `json:"managedPrefixList,omitempty"`

	// ProviderConfigRef references a ProviderConfig used to create this
	// resource
	//
	// If not provided, will fall back to the top-level ProviderConfigRef
	//
	// Required for cross account transit gateway peering
	//
	// +optional
	ProviderConfigRef xpv1.Reference `json:"providerConfigRef"`

	// Region the remote transit gateway is located in
	//
	// +optional
	Region string `json:"region"`
}

type TransitGatewayNamedVpc struct {
	// The name of the VPC
	//
	// +required
	Name string `json:"name"`

	TransitGatewayVpc `json:",inline"`
}

type TransitGatewayVpc struct {
	// Cidr blocks for the VPC
	//
	// +optional
	CidrBlocks []Cidr `json:"cidrBlocks"`

	// Prefix lists for the VPC
	//
	// +optional
	PrefixLists []PrefixList `json:"prefixLists"`

	// Region this VPC is located in
	//
	// +optional
	Region string `json:"region"`

	// Route table ids in the VPC
	//
	// +optional
	RouteTableIds []RouteTableId `json:"routeTableIds"`

	// SubnetIds in the VPC
	//
	// +optional
	SubnetIds []SubnetId `json:"subnetIds"`

	// The ID of the VPC
	//
	// +optional
	VpcId VpcId `json:"vpcId"`
}

type TransitGatewayVpcWithProviderConfig struct {
	TransitGatewayNamedVpc `json:",inline"`

	// ProviderConfigRef references a ProviderConfig used to create this
	// resource
	//
	// If not provided, will fall back to the top-level ProviderConfigRef
	//
	// Required for cross account VPCs
	// Should not be set for same account VPCs unless restricted by
	// IAM
	//
	// +optional
	ProviderConfigRef xpv1.Reference `json:"providerConfigRef"`
}

// +
type PrefixList struct {
	// If this is a blackhole route
	//
	// +optional
	// +default=false
	Blackhole bool `json:"blackhole"`

	// The ID of the prefix list.
	//
	// +optional
	Id string `json:"id"`

	// Outbound route
	//
	// This places it in the ManagedPrefixList attached
	// to the outbound route table
	//
	// +optional
	// +default=true
	Outbound bool `json:"outbound"`

	ManagedPrefixListSubParameters `json:",inline"`
}

// Resource Access Management (RAM)
type RAM struct {
	// Is RAM enabled
	//
	// +optional
	// +default=false
	Enabled bool `json:"enabled"`

	// Do we allow external principles with this ram
	//
	// +optional
	// +default=false
	AllowExternalPrincipals bool `json:"allowExternalPrincipals"`

	// Principals that are allowed to access the resource
	//
	// +optional
	Principals []string `json:"principals"`
}

// Repository type metadata.
var (
	TransitGatewayKind      = "TransitGateway"
	TransitGatewayGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  TransitGatewayKind,
	}.String()
	TransitGatewayKindAPIVersion   = TransitGatewayKind + "." + GroupVersion.String()
	TransitGatewayGroupVersionKind = GroupVersion.WithKind(TransitGatewayKind)
)
