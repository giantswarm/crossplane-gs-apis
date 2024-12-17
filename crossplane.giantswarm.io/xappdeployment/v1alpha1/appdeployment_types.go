package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// Repository type metadata.
var (
	AppDeploymentKind      = "AppDeployment"
	AppDeploymentGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  AppDeploymentKind,
	}.String()
	AppDeploymentKindAPIVersion   = AppDeploymentKind + "." + GroupVersion.String()
	AppDeploymentGroupVersionKind = GroupVersion.WithKind(AppDeploymentKind)
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=ad
// +crossbuilder:generate:xrd:claimNames:kind=AppDeploymentClaim,plural=appdeploymentclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=app-deployment
type AppDeployment struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   AppDeploymentSpec   `json:"spec"`
	Status AppDeploymentStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type AppDeploymentList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`

	Items []AppDeployment `json:"items"`
}

// Use the `spec` struct to contain parameters you might not want to share
// when nesting XRDs - these will usually be parameters that may be defined
// in a parent.

type AppDeploymentSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	AppDeploymentParameters `json:",inline"`
}

type AppDeploymentParameters struct {
}

type AppDeploymentStatus struct {
	xpv1.ConditionedStatus `json:",inline"`
}
