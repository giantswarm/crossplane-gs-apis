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

package eso

import ()

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Eso) DeepCopyInto(out *Eso) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.FluxSSASecretName != nil {
		in, out := &in.FluxSSASecretName, &out.FluxSSASecretName
		*out = new(string)
		**out = **in
	}
	if in.KubernetesSecretStore != nil {
		in, out := &in.KubernetesSecretStore, &out.KubernetesSecretStore
		*out = new(string)
		**out = **in
	}
	in.TenantCluster.DeepCopyInto(&out.TenantCluster)
	if in.Stores != nil {
		in, out := &in.Stores, &out.Stores
		*out = make([]SecretsStore, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Eso.
func (in *Eso) DeepCopy() *Eso {
	if in == nil {
		return nil
	}
	out := new(Eso)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SecretsStore) DeepCopyInto(out *SecretsStore) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.Name != nil {
		in, out := &in.Name, &out.Name
		*out = new(string)
		**out = **in
	}
	if in.IsClusterSecretStore != nil {
		in, out := &in.IsClusterSecretStore, &out.IsClusterSecretStore
		*out = new(bool)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SecretsStore.
func (in *SecretsStore) DeepCopy() *SecretsStore {
	if in == nil {
		return nil
	}
	out := new(SecretsStore)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *TenantCluster) DeepCopyInto(out *TenantCluster) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new TenantCluster.
func (in *TenantCluster) DeepCopy() *TenantCluster {
	if in == nil {
		return nil
	}
	out := new(TenantCluster)
	in.DeepCopyInto(out)
	return out
}
