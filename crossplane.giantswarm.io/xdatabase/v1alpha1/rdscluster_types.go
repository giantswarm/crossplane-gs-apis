package v1alpha1

import (
	nd "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"

	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
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

	// Database defines the database settings
	//
	// +required
	Database ClusterParameters `json:"database"`

	// SubnetGroupIndexes is a map of service name to subnet set indexes
	//
	// +required
	SubnetGroupIndexes SubnetGroupIndexes `json:"subnetGroupIndexes,omitempty"`

	// Region is the region in which this collection will be created
	//
	// +required
	Region string `json:"region"`

	// Vpc defines the VPC settings
	//
	// +required
	Vpc xnet.PeeredVpcNetworkParameters `json:"vpc"`
}

// RdsClusterStatus defines the observed state of RdsCluster
type RdsClusterStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// CacheEndpoint is the endpoint of the Elasticache
	//
	// +optional
	CacheEndpoint string `json:"cacheEndpoint,omitempty"`

	// CachePort is the port of the Elasticache
	//
	// +optional
	CachePort int `json:"cachePort,omitempty"`

	// CacheSubnets is the list of subnets to be used by ElasticSearch
	//
	// +optional
	CacheSubnets []string `json:"cacheSubnets,omitempty"`

	// DatabaseEndpoint is the endpoint of the database
	//
	// +optional
	DatabaseEndpoint string `json:"databaseEndpoint,omitempty"`

	// DatabasePort is the port of the database
	//
	// +optional
	DatabasePort int `json:"databasePort,omitempty"`

	// DatabaseSubnets is the list of subnets to be used by the database
	//
	// +optional
	DatabaseSubnets []string `json:"databaseSubnets,omitempty"`

	// Vpc is a VPC configuration to bind the cluster to
	//
	// +optional
	Vpc nd.Vpc `json:"vpc,omitempty"`
}

// Repository type metadata.
var (
	RdsCacheClusterKind      = "RdsCacheCluster"
	RdsCacheClusterGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RdsBaseDbClusterKind,
	}.String()
	RdsCacheClusterKindAPIVersion   = RdsCacheClusterKind + "." + GroupVersion.String()
	RdsCacheClusterGroupVersionKind = GroupVersion.WithKind(RdsCacheClusterKind)
)
