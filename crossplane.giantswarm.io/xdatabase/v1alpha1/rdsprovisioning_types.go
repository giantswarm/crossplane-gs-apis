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
// +kubebuilder:resource:shortName=rdsprv
// +crossbuilder:generate:xrd:claimNames:kind=RdsProvisioningClaim,plural=rdsprovisioningclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=rds-provisioning
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=rds-provisioning
type RdsProvisioning struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   RdsProvisioningSpec   `json:"spec"`
	Status RdsProvisioningStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type RdsProvisioningList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []RdsProvisioning `json:"items"`
}

// RdsProvisioningSpec defines the desired state of RdsProvisioning
type RdsProvisioningSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// Sets the parameters for the provisioning
	RdsProvisioningParameters `json:",inline"`

	// KubernetesProviderConfig is the provider config for the Kubernetes provider.
	//
	// +required
	KubernetesProviderConfig *xpv1.Reference `json:"kubernetesProviderConfig,omitempty"`
}

// Defines the parameters for the RDS provisioning
type RdsProvisioningParameters struct {
	// Determines if the RDS provisioning should be enabled
	//
	// +optional
	// +default=true
	Enabled bool `json:"enabled"`

	// The name of the connection secret to use for the RDS instance
	//
	// Required if `providerConfigRef` is not provided, ignored otherwise
	// Must exist in the same namespace as the provisioning claim
	//
	// If this value is provided, the composition will attempt to create a
	// provider config using the engine specific providerconfig spec
	//
	// +optional
	ConnectionSecretName *string `json:"connectionSecretName,omitempty"`

	// Databases is a map of databases to create.
	//
	// +optional
	// +mapType=atomic
	Databases map[DatabaseName]SqlUsers `json:"databases,omitempty"`

	// The type of database engine being provisioned
	//
	// +optional
	// +default="postgres"
	Engine *string `json:"engine,omitempty"`
}

// RdsProvisioningStatus defines the observed state of RdsProvisioning
type RdsProvisioningStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// Is the provisioning ready
	//
	// +optional
	Ready bool `json:"ready,omitempty"`

	// Connection secrets created for the databases
	//
	// +optional
	ConnectionSecrets RdsProvisioningConnectionSecrets `json:"connectionSecrets,omitempty"`
}

type RdsProvisioningConnectionSecrets struct {
	// The name of the secret created specifically for the app
	//
	// +optional
	App string `json:"app,omitempty"`

	// A map of secret names created for users
	//
	// +optional
	Users map[string]string `json:"users,omitempty"`
}

// The name of the database to create
type DatabaseName string

// SecretReference is a reference to a Secret
type SecretReference struct {
	// Name of the secret
	// +kubebuilder:validation:Required
	Name string `json:"name"`

	// Namespace of the secret
	// +kubebuilder:validation:Required
	Namespace string `json:"namespace"`
}

// Defines a user to create in the database
//
// See the provider specific documentation for the available configuration
// parameters.
//
// With the exception of `configurationParameters`, all fields should be
// created as elements directly on the user object and not as nested objects.
//
// +kubebuilder:pruning:PreserveUnknownFields
type SqlUser struct {
	// ConfigurationParameters is the configuration parameters for the user.
	//
	// Only applicable for postgresql databases
	//
	// +optional
	ConfigurationParameters map[string]*string `json:"configurationParameters,omitempty"`

	// Privileges is a list of privileges to grant to the user.
	//
	// +optional
	Privileges []string `json:"privileges,omitempty"`
}

// A list of SqlUser objects to use for the database
//
// +mapType=atomic
type SqlUsers map[string]SqlUser

// Repository type metadata.
var (
	RdsProvisioningKind      = "RdsProvisioning"
	RdsProvisioningGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  RdsProvisioningKind,
	}.String()
	RdsProvisioningKindAPIVersion   = RdsProvisioningKind + "." + GroupVersion.String()
	RdsProvisioningGroupVersionKind = GroupVersion.WithKind(RdsProvisioningKind)
)
