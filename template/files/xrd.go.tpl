package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	<GROUP_CLASS>Kind      = "<GROUP_CLASS>"
	<GROUP_CLASS>GroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  <GROUP_CLASS>Kind,
	}.String()
	<GROUP_CLASS>KindAPIVersion   = <GROUP_CLASS>Kind + "." + GroupVersion.String()
	<GROUP_CLASS>GroupVersionKind = GroupVersion.WithKind(<GROUP_CLASS>Kind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=<SHORTNAME>
// +crossbuilder:generate:xrd:claimNames:kind=<GROUP_CLASS>Claim,plural=<GROUP_CLASS_LOWER>claims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=<COMPOSITION>
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=<COMPOSITION>
type <GROUP_CLASS> struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   <GROUP_CLASS>Spec   `json:"spec"`
	Status <GROUP_CLASS>Status `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type <GROUP_CLASS>List struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []<GROUP_CLASS> `json:"items"`
}

// Use the `spec` struct to contain parameters you might not want to share
// when nesting XRDs - these will usually be parameters that may be defined
// in a parent.

type <GROUP_CLASS>Spec struct {
	xpv1.ResourceSpec `json:",inline"`

	<GROUP_CLASS>Parameters `json:",inline"`
}

type <GROUP_CLASS>Parameters struct {
}

type <GROUP_CLASS>Status struct {
	xpv1.ConditionedStatus `json:",inline"`
}
