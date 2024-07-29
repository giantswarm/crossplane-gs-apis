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
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:printcolumn:name="Region",type=string,JSONPath=`.spec.region`
// +kubebuilder:printcolumn:name="VpcID",type=string,JSONPath=`.status.vpcID`
// +kubebuilder:resource:shortName=dscvr
// +crossbuilder:generate:xrd:claimNames:kind=DiscoveryClaim,plural=networkdiscoveryclaims
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

	Enabled bool `json:"enabled"`

	GroupBy string `json:"groupBy"`

	ProviderType string `json:"providerType"`

	Region string `json:"region"`

	RemoteVpcs []VpcPeer `json:"remoteVpcs"`
}

type DiscoveryStatus struct {
	xpv1.ResourceStatus `json:",inline"`

	Vpcs map[string]nd.AwsVpc `json:"vpcs"`
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
