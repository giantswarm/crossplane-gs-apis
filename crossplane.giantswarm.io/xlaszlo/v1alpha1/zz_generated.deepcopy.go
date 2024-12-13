//go:build !ignore_autogenerated

/*
Copyright  The Crossbuilder Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	"github.com/fluxcd/helm-controller/api/v2beta1"
	"github.com/fluxcd/pkg/apis/meta"
	apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ChartParameters) DeepCopyInto(out *ChartParameters) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ChartParameters.
func (in *ChartParameters) DeepCopy() *ChartParameters {
	if in == nil {
		return nil
	}
	out := new(ChartParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DatabaseEsoParameters) DeepCopyInto(out *DatabaseEsoParameters) {
	*out = *in
	out.TenantCluster = in.TenantCluster
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new DatabaseEsoParameters.
func (in *DatabaseEsoParameters) DeepCopy() *DatabaseEsoParameters {
	if in == nil {
		return nil
	}
	out := new(DatabaseEsoParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DatabaseParameters) DeepCopyInto(out *DatabaseParameters) {
	*out = *in
	if in.Engine != nil {
		in, out := &in.Engine, &out.Engine
		*out = new(string)
		**out = **in
	}
	out.DatabaseEsoParameters = in.DatabaseEsoParameters
	out.ProviderConfigRef = in.ProviderConfigRef
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new DatabaseParameters.
func (in *DatabaseParameters) DeepCopy() *DatabaseParameters {
	if in == nil {
		return nil
	}
	out := new(DatabaseParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DeploymentParameters) DeepCopyInto(out *DeploymentParameters) {
	*out = *in
	out.ChartParameters = in.ChartParameters
	if in.DependsOn != nil {
		in, out := &in.DependsOn, &out.DependsOn
		*out = make([]meta.NamespacedObjectReference, len(*in))
		copy(*out, *in)
	}
	if in.KubeConfig != nil {
		in, out := &in.KubeConfig, &out.KubeConfig
		*out = new(meta.KubeConfigReference)
		**out = **in
	}
	if in.ValuesFrom != nil {
		in, out := &in.ValuesFrom, &out.ValuesFrom
		*out = new(v2beta1.ValuesReference)
		**out = **in
	}
	if in.Values != nil {
		in, out := &in.Values, &out.Values
		*out = new(apiextensionsv1.JSON)
		(*in).DeepCopyInto(*out)
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new DeploymentParameters.
func (in *DeploymentParameters) DeepCopy() *DeploymentParameters {
	if in == nil {
		return nil
	}
	out := new(DeploymentParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Example) DeepCopyInto(out *Example) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Example.
func (in *Example) DeepCopy() *Example {
	if in == nil {
		return nil
	}
	out := new(Example)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *Example) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExampleConfigMapParameters) DeepCopyInto(out *ExampleConfigMapParameters) {
	*out = *in
	in.Database.DeepCopyInto(&out.Database)
	in.DeploymentParameters.DeepCopyInto(&out.DeploymentParameters)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExampleConfigMapParameters.
func (in *ExampleConfigMapParameters) DeepCopy() *ExampleConfigMapParameters {
	if in == nil {
		return nil
	}
	out := new(ExampleConfigMapParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExampleList) DeepCopyInto(out *ExampleList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]Example, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExampleList.
func (in *ExampleList) DeepCopy() *ExampleList {
	if in == nil {
		return nil
	}
	out := new(ExampleList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ExampleList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExampleParameters) DeepCopyInto(out *ExampleParameters) {
	*out = *in
	in.ExampleConfigMapParameters.DeepCopyInto(&out.ExampleConfigMapParameters)
	if in.KubernetesProviderConfig != nil {
		in, out := &in.KubernetesProviderConfig, &out.KubernetesProviderConfig
		*out = new(v1.Reference)
		(*in).DeepCopyInto(*out)
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExampleParameters.
func (in *ExampleParameters) DeepCopy() *ExampleParameters {
	if in == nil {
		return nil
	}
	out := new(ExampleParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExampleSpec) DeepCopyInto(out *ExampleSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
	in.ExampleParameters.DeepCopyInto(&out.ExampleParameters)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExampleSpec.
func (in *ExampleSpec) DeepCopy() *ExampleSpec {
	if in == nil {
		return nil
	}
	out := new(ExampleSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ExampleStatus) DeepCopyInto(out *ExampleStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ExampleStatus.
func (in *ExampleStatus) DeepCopy() *ExampleStatus {
	if in == nil {
		return nil
	}
	out := new(ExampleStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ProviderConfigRefParameters) DeepCopyInto(out *ProviderConfigRefParameters) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ProviderConfigRefParameters.
func (in *ProviderConfigRefParameters) DeepCopy() *ProviderConfigRefParameters {
	if in == nil {
		return nil
	}
	out := new(ProviderConfigRefParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *TenantClusterParameters) DeepCopyInto(out *TenantClusterParameters) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new TenantClusterParameters.
func (in *TenantClusterParameters) DeepCopy() *TenantClusterParameters {
	if in == nil {
		return nil
	}
	out := new(TenantClusterParameters)
	in.DeepCopyInto(out)
	return out
}
