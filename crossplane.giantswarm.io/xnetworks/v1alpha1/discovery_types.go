package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane;network
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=dscvr
// +crossbuilder:generate:xrd:claimNames:kind=DiscoveryClaim,plural=discoveryclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=network-discovery
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=network-discovery
type Discovery struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   DiscoverySpec   `json:"spec"`
	Status DiscoveryStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type DiscoveryList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []Discovery `json:"items"`
}

type DiscoverySpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Whether this discovery is enabled.
	//
	// +optional
	// +kubeBuilder:default=true
	Enabled bool `json:"enabled"`

	// A tag that can be referenced to group subnets and route tables
	// into subnetsets.
	//
	// The tag must have an integer value
	//
	// +optional
	// +kubeBuilder:default="giantswarm.io/subnetset"
	GroupBy string `json:"groupBy"`

	// The name of the provider config to use for creating kubernetes resources.
	//
	// +required
	KubernetesProviderConfigRef xpv1.Reference `json:"kubernetesProviderConfigRef"`

	// The name of the provider config to use for looking up remote VPCs.
	//
	// +required
	ProviderType string `json:"providerType"`

	// The default region to look in.
	//
	// +required
	Region string `json:"region"`

	// Details about the remove VPCs to look up.
	//
	// +required
	RemoteVpcs []VpcPeer `json:"remoteVpcs"`
}

type DiscoveryStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// The VPCs that have been discovered.
	//
	// +optional
	Vpcs map[string]nd.AwsVpc `json:"vpcs,omitempty"`
}

// Repository type metadata.
var (
	DiscoveryKind      = "Discovery"
	DiscoveryGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  DiscoveryKind,
	}.String()
	DiscoveryKindAPIVersion   = DiscoveryKind + "." + GroupVersion.String()
	DiscoveryGroupVersionKind = GroupVersion.WithKind(DiscoveryKind)
)
