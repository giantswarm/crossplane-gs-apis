package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
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
	// Name of the configmap
	//
	// +required
	Name string `json:"name,omitempty"`

	// Namespace of the configmap
	//
	// +required
	Namespace string `json:"namespace,omitempty"`

	// Message to store in the configmap
	//
	// +required
	Message string `json:"message,omitempty"`
}

type ExampleStatus struct {
	xpv1.ConditionedStatus `json:",inline"`
}
