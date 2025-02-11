package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	"github.com/giantswarm/crossplane-gs-apis/pkg/eso"
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
// +kubebuilder:resource:shortName=ld
// +crossbuilder:generate:xrd:claimNames:kind=LogicalDatabaseClaim,plural=logicaldatabaseclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=logical-database
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=logical-database
type RdsLogicalDatabase struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   RdsLogicalDatabaseSpec   `json:"spec"`
	Status RdsLogicalDatabaseStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type RdsLogicalDatabaseList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []RdsLogicalDatabase `json:"items"`
}

// RdsLogicalDatabaseSpec defines the desired state of RdsLogicalDatabase
type RdsLogicalDatabaseSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Sets the parameters for the provisioning
	RdsLogicalDatabaseParameters `json:",inline"`

	// Eso is the configuration for the external secrets operator
	//
	// +optional
	Eso *eso.Eso `json:"eso,omitempty"`

	// KubernetesProviderConfig is the provider config for the Kubernetes provider.
	//
	// +required
	KubernetesProviderConfig *xpv1.Reference `json:"kubernetesProviderConfig,omitempty"`
}

// Defines the parameters for the RDS provisioning
type RdsLogicalDatabaseParameters struct {
	// Databases is a map of databases to create.
	//
	// +optional
	Databases map[DatabaseName]DatabaseConfig `json:"databases,omitempty"`

	// The type of database engine being provisioned
	//
	// +optional
	// +kubeBuilder:default="postgres"
	// +kubebuilder:validation:Enum=postgres;mysql;aurora-postgresql;aurora-mysql
	Engine *string `json:"engine,omitempty"`
}

type DatabaseConfig struct {
	// A map of users to create for the database
	//
	// +optional
	Users map[DatabaseUserName]SqlUser `json:"users"`
}

// RdsLogicalDatabaseStatus defines the observed state of RdsLogicalDatabase
type RdsLogicalDatabaseStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// Is the provisioning ready
	//
	// +optional
	Ready bool `json:"ready,omitempty"`

	// Connection secrets created for the databases
	//
	// +optional
	ConnectionSecrets RdsLogicalDatabaseConnectionSecrets `json:"connectionSecrets,omitempty"`
}

type RdsLogicalDatabaseConnectionSecrets struct {
	// The name of the secret created specifically for the app
	//
	// +optional
	App string `json:"app,omitempty"`

	// A map of secret names created for users
	//
	// +optional
	Users map[string]string `json:"users,omitempty"`
}

// Repository type metadata.
var (
	RdsLogicalDatabaseKind      = "RdsLogicalDatabase"
	RdsLogicalDatabaseGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RdsLogicalDatabaseKind,
	}.String()
	RdsLogicalDatabaseKindAPIVersion   = RdsLogicalDatabaseKind + "." + GroupVersion.String()
	RdsLogicalDatabaseGroupVersionKind = GroupVersion.WithKind(RdsLogicalDatabaseKind)
)
