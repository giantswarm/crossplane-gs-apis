package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	xrds "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xdatabase/v1alpha1"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=rccwrl
// +crossbuilder:generate:xrd:claimNames:kind=RCCWithRegionLookupClaim,plural=rccwithregionlookupclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=rcc-with-region-lookup
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=rcc-with-region-lookup
type RdsCacheClusterWithRegionLookup struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   RdsCacheClusterWithRegionLookupSpec   `json:"spec"`
	Status RdsCacheClusterWithRegionLookupStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type RdsCacheClusterWithRegionLookupList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []RdsCacheClusterWithRegionLookup `json:"items"`
}

type ClusterDiscovery struct {
	xpv1.ResourceSpec `json:",inline"`
	// Name is the name of the cluster to discover
	//
	// +required
	Name string `json:"name"`

	// Namespace is the namespace of the cluster to discover
	//
	// +required
	Namespace string `json:"namespace"`
}

// RdsCacheClusterWithRegionLookupSpec contains the structure required for building the
// infrastructure for an RDS + Elasticache Cluster.
type RdsCacheClusterWithRegionLookupSpec struct {
	// ClusterDiscovery is the reference to the cluster to discover
	//
	// +required
	ClusterDiscovery ClusterDiscovery `json:"clusterDiscovery"`

	// RdsCacheClusterSpec is the spec for the RDS Cache Cluster
	//
	// +required
	RdsCacheClusterSpec xrds.RdsCacheClusterSpec `json:"rdsCacheClusterSpec"`
}

type RdsCacheClusterWithRegionLookupStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// CacheClusterEndpoints is a list of endpoints of the Elasticache clusters
	// when the cache is configured in cluster mode
	//
	// +optional
	CacheClusterEndpoints []string `json:"cacheClusterEndpoints,omitempty"`

	// CacheConnectionSecret is the secret containing the connection details for
	// the Elasticache replication group
	//
	// +optional
	CacheConnectionSecret string `json:"cacheConnectionSecret,omitempty"`

	// CacheEndpoint is the endpoint of the Elasticache replication group
	//
	// +optional
	CacheEndpoint string `json:"cacheEndpoint,omitempty"`

	// CacheGlobalConnectionSecret is the name of the global connection secret for the
	// Elasticache cluster
	//
	// +optional
	CacheGlobalConnectionSecret string `json:"cacheGlobalConnectionSecret,omitempty"`

	// CacheGlobalEndpoint is the global (RW) endpoint of the Elasticache
	// global replication group
	//
	// +optional
	CacheGlobalEndpoint string `json:"cacheGlobalEndpoint,omitempty"`

	// CacheGlobalReaderEndpoint is the global (RO) endpoint of the Elasticache
	// global replication group
	//
	// +optional
	CacheGlobalReaderEndpoint string `json:"cacheGlobalReaderEndpoint,omitempty"`

	// CachePort is the port of the Elasticache
	//
	// +optional
	CachePort int `json:"cachePort,omitempty"`

	// CacheReaderEndpoint is the reader endpoint of the Elasticache replication
	// group
	//
	// +optional
	CacheReaderEndpoint string `json:"cacheReaderEndpoint,omitempty"`

	// CacheSubnets is the list of subnets to be used by ElasticSearch
	//
	// +optional
	CacheSubnets []string `json:"cacheSubnets,omitempty"`

	// RdsConnectionSecret is the secret containing the connection details
	// for the database
	//
	// +optional
	RdsConnectionSecret string `json:"rdsConnectionSecret,omitempty"`

	// RdsEndpoint is the endpoint of the database
	//
	// +optional
	RdsEndpoint string `json:"rdsEndpoint,omitempty"`

	// RdsPort is the port of the database
	//
	// +optional
	RdsPort int `json:"rdsPort,omitempty"`

	// RdsSubnets is the list of subnets to be used by the database
	//
	// +optional
	RdsSubnets []string `json:"rdsSubnets,omitempty"`

	// Vpc is a VPC configuration to bind the cluster to
	//
	// +optional
	Vpc nd.AwsVpc `json:"vpc,omitempty"`
}

// Repository type metadata.
var (
	RdsCacheClusterWithRegionLookupKind      = "RdsCacheClusterWithRegionLookup"
	RdsCacheClusterWithRegionLookupGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RdsCacheClusterWithRegionLookupKind,
	}.String()
	RdsCacheClusterWithRegionLookupKindAPIVersion   = RdsCacheClusterWithRegionLookupKind + "." + GroupVersion.String()
	RdsCacheClusterWithRegionLookupGroupVersionKind = GroupVersion.WithKind(RdsCacheClusterWithRegionLookupKind)
)
