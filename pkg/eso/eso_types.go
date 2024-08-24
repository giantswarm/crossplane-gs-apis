package eso

// ExternalSecretsOperator (ESO) is the configuration for the external secrets
// operator.
//
// If enabled will duplicate the RDS connection secret to a secret managed by
// external secrets operator which standardises the fields for use with
// provider-sql.
//
// Additionally, PushSecrets can be automatically created to push the secret to
// external secrets stores.
//
// +kubebuilder:object:root=false
// +kubebuilder:object:generate=true
type Eso struct {
	// Enabled Whether or not to enable `external-secrets-operator` object
	// deployments using `provider-kubernetes.
	//
	// +optional
	// +default=true
	Enabled *bool `json:"enabled,omitempty"`

	// FluxSSASecretName is the name of the secret that contains SSA details
	// for each project built with infrastructure components.
	//
	// This secret will be updated with the name of the current project with
	// all hyphens, underscores and dots replaced with an empty string.
	//
	// This secret must exist in the same namespace as the current project.
	//
	// +optional
	FluxSSASecretName *string `json:"fluxSSASecretName,omitempty"`

	// KubernetesSecretStore is the Kubernetes secret store to use.
	//
	// The kubernetes secret store is expected to be namespace scoped to prevent
	// secrets leaking across namespaces.
	//
	// +optional
	// +default="default"
	KubernetesSecretStore *string `json:"kubernetesSecretStore,omitempty"`

	// Tenant Cluster details
	//
	// +optional
	TenantCluster TenantCluster `json:"tenantCluster,omitempty"`

	// Stores is a list of secret stores to use for push secrets.
	//
	// +optional
	Stores []SecretsStore `json:"stores,omitempty"`
}

// SecretsStore is a reference to a secrets store to be passed to External
// Secrets Operator for creating PushSecrets
//
// +kubebuilder:object:root=false
// +kubebuilder:object:generate=true
type SecretsStore struct {
	// Enabled is whether the secrets store is enabled.
	//
	// +optional
	// +default=true
	Enabled *bool `json:"enabled,omitempty"`

	// SecretStoreName is the name of the secret store.
	//
	// +required
	SecretStoreName *string `json:"secretStore"`

	// IsClusterSecretStore is whether the secret store is a cluster secret store.
	//
	// +optional
	// +default=false
	IsClusterSecretStore *bool `json:"isClusterSecretStore,omitempty"`
}

// TenantCluster is the configuration for the tenant cluster.
//
// +kubebuilder:object:root=false
// +kubebuilder:object:generate=true
// +kubebuilder:validation:XValidation:rule="self.enabled == true && self.namespace != null",message="namespace must be set when enabled is true"
// +kubebuilder:validation:XValidation:rule="self.enabled == true && self.apiServerEndpoint != null",message="apiServerEndpoint must be set when enabled is true"
// +kubebuilder:validation:XValidation:rule="self.enabled == true && self.clusterName != null",message="clusterName must be set when enabled is true"
type TenantCluster struct {
	// Enabled Whether or not to enable `external-secrets-operator` object
	// deployments using `provider-kubernetes.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled"`

	// The namespace to deploy the external secrets operator in.
	//
	// +optional
	Namespace string `json:"namespace,omitempty"`

	// The API endpoint for the tenant cluster.
	//
	// +optional
	ApiServerEndpoint string `json:"apiServerEndpoint,omitempty"`

	// The name of the tenant cluster.
	//
	// +optional
	ClusterName string `json:"clusterName,omitempty"`
}
