package v1alpha1

import (
	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	xcache "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xcache/v1alpha1"
	xdb "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xdatabase/v1alpha1"
	xnet "github.com/giantswarm/crossplane-gs-apis/crossplane.giantswarm.io/xnetworks/v1alpha1"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=rdscc
// +crossbuilder:generate:xrd:claimNames:kind=RdsCacheClusterClaim,plural=rdscacheclusterclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=rds-cache-cluster
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=rds-cache-cluster
type RdsCacheCluster struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   RdsCacheClusterSpec `json:"spec"`
	Status RdsClusterStatus    `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type RdsCacheClusterList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []RdsCacheCluster `json:"items"`
}

type SubnetGroupIndexes struct {
	// Database is the subnet group index to use for the database
	//
	// +required
	Database int `json:"database"`

	// Cache is the subnet group index to use for the cache
	//
	// +required
	Cache int `json:"cache"`
}

// RdsCacheClusterSpec contains the structure required for building the
// infrastructure for an RDS + Elasticache Cluster.
type RdsCacheClusterSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Cache defines the cache settings
	//
	// +required
	Cache xcache.ReplicationGroup `json:"cache"`

	// Database defines the database settings
	//
	// +required
	Database xdb.ClusterParameters `json:"database"`

	// KubernetesProviderConfig
	//
	// +required
	KubernetesProviderConfig *xdb.ProviderConfig `json:"kubernetesProviderConfig"`

	// SubnetGroupIndexes is a map of service name to subnet set indexes
	//
	// +required
	SubnetGroupIndexes SubnetGroupIndexes `json:"subnetGroupIndexes,omitempty"`

	// Region is the region in which this collection will be created
	//
	// +required
	Region string `json:"region"`

	// AvailabilityZones is the list of availability zones to be used by the cluster
	//
	// +required
	// +kubebuilder:validation:MinItems=3
	// +kubebuilder:validation:MaxItems=3
	AvailabilityZones []string `json:"availabilityZones"`

	// Vpc defines the VPC settings
	//
	// +required
	Vpc xnet.PeeredVpcNetworkParameters `json:"vpc"`
}

// RdsClusterStatus defines the observed state of RdsCluster
type RdsClusterStatus struct {
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

	// CacheGlobalConnectionSecret is the secret containing the connection
	// details for the global Elasticache replication group
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
	RdsCacheClusterKind      = "RdsCacheCluster"
	RdsCacheClusterGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RdsCacheClusterKind,
	}.String()
	RdsCacheClusterKindAPIVersion   = RdsCacheClusterKind + "." + GroupVersion.String()
	RdsCacheClusterGroupVersionKind = GroupVersion.WithKind(RdsCacheClusterKind)
)
