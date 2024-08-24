package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
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
type RCCWithRegionLookup struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   RCCWithRegionLookupSpec   `json:"spec"`
	Status RCCWithRegionLookupStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type RCCWithRegionLookupList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []RCCWithRegionLookup `json:"items"`
}

type ClusterDiscovery struct {
	// Name is the name of the cluster to discover
	//
	// +required
	Name string `json:"name"`

	// Namespace is the namespace of the cluster to discover
	//
	// +required
	Namespace string `json:"namespace"`

	// RemoteNamespace is the namespace on the remote cluster to
	// apply secrets into. If not specified, the default namespace
	// is used.
	//
	// +optional
	// +default="default"
	RemoteNamespace string `json:"remoteNamespace"`
}

// RCCWithRegionLookupSpec contains the structure required for building the
// infrastructure for an RDS + Elasticache Cluster.
type RCCWithRegionLookupSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// ClusterDiscovery is the reference to the cluster to discover
	//
	// +required
	ClusterDiscovery ClusterDiscovery `json:"clusterDiscovery"`

	// KubernetesProviderConfig
	//
	// +required
	KubernetesProviderConfig *xpv1.Reference `json:"kubernetesProviderConfig"`

	// ManagementClusterDiscovery is the reference to the management cluster
	//
	// +required
	ManagementClusterDiscovery ClusterDiscovery `json:"managementClusterDiscovery"`

	// RdsCacheClusterSpec is the spec for the RDS Cache Cluster
	//
	// +required
	RdsCacheClusterParameters RdsCacheClusterParameters `json:"rdsCacheClusterParameters"`
}

type RCCWithRegionLookupStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// AvailabilityZones is the list of availability zones to be used by the cluster
	//
	// +optional
	AvailabilityZones []string `json:"availabilityZones,omitempty"`

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

	// Region for the management cluster
	//
	// +optional
	McRegion string `json:"mcregion,omitempty"`

	// Is the composition complete
	//
	// +optional
	Ready bool `json:"ready,omitempty"`

	// Region is the region in which the resources are created
	//
	// +optional
	Region string `json:"region,omitempty"`

	// RdsConnectionSecret is the secret containing the connection details
	// for the database
	//
	// +optional
	RdsConnectionSecret string `json:"rdsConnectionSecret,omitempty"`

	// RdsEndpoint is the endpoint of the database
	//
	// +optional
	RdsEndpoint string `json:"rdsEndpoint,omitempty"`

	// RdsReaderEndpoint is the reader endpoint of the database
	//
	// +optional
	RdsReaderEndpoint string `json:"rdsReaderEndpoint,omitempty"`

	// RdsPort is the port of the database
	//
	// +optional
	RdsPort int `json:"rdsPort,omitempty"`

	// RdsSubnets is the list of subnets to be used by the database
	//
	// +optional
	RdsSubnets []string `json:"rdsSubnets,omitempty"`

	// The API server endpoint for the tenant cluster
	//
	// +optional
	TenantApiServerEndpoint string `json:"tenantApiServerEndpoint,omitempty"`

	// Vpc is a VPC configuration to bind the cluster to
	//
	// +optional
	Vpc nd.AwsVpc `json:"vpc,omitempty"`
}

// Repository type metadata.
var (
	RCCWithRegionLookupKind      = "RCCWithRegionLookup"
	RCCWithRegionLookupGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RCCWithRegionLookupKind,
	}.String()
	RCCWithRegionLookupKindAPIVersion   = RCCWithRegionLookupKind + "." + GroupVersion.String()
	RCCWithRegionLookupGroupVersionKind = GroupVersion.WithKind(RCCWithRegionLookupKind)
)
