package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	v2beta1 "github.com/fluxcd/helm-controller/api/v2beta1"
	"github.com/fluxcd/pkg/apis/meta"
	apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	ExampleKind      = "Example"
	ExampleGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  ExampleKind,
	}.String()
	ExampleKindAPIVersion   = ExampleKind + "." + GroupVersion.String()
	ExampleGroupVersionKind = GroupVersion.WithKind(ExampleKind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=ex
// +crossbuilder:generate:xrd:claimNames:kind=ExampleClaim,plural=exampleclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=test
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=test
type Example struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   ExampleSpec   `json:"spec"`
	Status ExampleStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type ExampleList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []Example `json:"items"`
}

// Use the `spec` struct to contain parameters you might not want to share
// when nesting XRDs - these will usually be parameters that may be defined
// in a parent.

type ExampleSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	ExampleParameters `json:",inline"`
}

type ExampleParameters struct {
	ExampleConfigMapParameters `json:",inline"`

	// KubernetesProviderConfig is the provider config for the Kubernetes provider.
	//
	// +required
	KubernetesProviderConfig *xpv1.Reference `json:"kubernetesProviderConfig,omitempty"`
}

type ExampleConfigMapParameters struct {
	// Name of the configmap.
	//
	// +required
	Name string `json:"name,omitempty"`

	// Namespace of the configmap
	//
	// +required
	Namespace string `json:"namespace,omitempty"`

	// Message to store in the configmap.
	//
	// +required
	Message string `json:"message,omitempty"`

	// Database parameters.
	//
	// +optional
	Database DatabaseParameters `json:"database,omitempty"`

	// Deployment parameters.
	//
	// +optional
	DeploymentParameters `json:",inline"`
}

type DatabaseParameters struct {
	// The type of database engine being provisioned.
	//
	// +optional
	// +default="postgres"
	// +kubebuilder:validation:Enum=postgres;mysql;aurora-postgresql;aurora-mysql
	Engine *string `json:"engine,omitempty"`

	DatabaseEsoParameters `json:"eso,omitempty"`

	// Provider config reference for the database claim.
	//
	// +optional
	ProviderConfigRef ProviderConfigRefParameters `json:"providerConfigRef,omitempty"`
}

type DatabaseEsoParameters struct {
	// Name of the secret that contains SSA details.
	//
	// +optional
	ClusterSsaField string `json:"clusterSsaField,omitempty"`

	// Configuration for the tenant cluster.
	//
	// +optional
	TenantCluster TenantClusterParameters `json:"tenantCluster,omitempty"`
}

// TenantCluster is the configuration for the tenant cluster.
//
// +kubebuilder:object:root=false
// +kubebuilder:object:generate=true
type TenantClusterParameters struct {
	// API endpoint URL of the target cluster.
	//
	// +optional
	ApiServerEndpoint string `json:"apiServerEndpoint,omitempty"`

	// Name of the target cluster.
	//
	// +optional
	ClusterName string `json:"clusterName,omitempty"`

	// Whether or not to enable `external-secrets-operator` object
	// deployments using `provider-kubernetes.
	//
	// +optional
	// +default=false
	Enabled bool `json:"enabled,omitempty"`
}

type ProviderConfigRefParameters struct {
	// Name of the provider config for the database claim
	//
	// +optional
	Name string `json:"string,omitempty"`
}

type DeploymentParameters struct {
	IngressHost string `json:"ingressHost,omitempty"`

	Interval string `json:"interval,omitempty"`

	StorageNamespace string `json:"storageNamespace,omitempty"`

	Suspend bool `json:"suspend,omitempty"`

	TargetNamespace string `json:"targetNamespace,omitempty"`

	Timeout string `json:"timeout,omitempty"`

	Version string `json:"version,omitempty"`

	ReleaseName string `json:"releaseName,omitempty"`
	ƒ
	ServiceAccountName string `json:"serviceAccountName,omitempty"`

	// DependsOn may contain a meta.NamespacedObjectReference slice with
	// references to HelmRelease resources that must be ready before the HelmRelease can be reconciled.
	//
	// +optional
	DependsOn []meta.NamespacedObjectReference `json:"dependsOn,omitempty"`

	// KubeConfig for reconciling the HelmRelease on a remote cluster.
	//
	// +optional
	KubeConfig *meta.KubeConfigReference `json:"kubeConfig,omitempty"`

	// ValuesFrom holds references to resources containing Helm values for this HelmRelease,
	// and information about how they should be merged.
	//
	// +optional
	ValuesFrom *v2beta1.ValuesReference `json:"valuesFrom,omitempty"`

	// Values holds the values for this Helm release.
	//
	// +optional
	Values *apiextensionsv1.JSON `json:"values,omitempty"`
}

type ExampleStatus struct {
	xpv1.ConditionedStatus `json:",inline"`
}
