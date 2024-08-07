//go:build !ignore_autogenerated

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Principal) DeepCopyInto(out *Principal) {
	*out = *in
	in.ProviderConfig.DeepCopyInto(&out.ProviderConfig)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Principal.
func (in *Principal) DeepCopy() *Principal {
	if in == nil {
		return nil
	}
	out := new(Principal)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RamParameters) DeepCopyInto(out *RamParameters) {
	*out = *in
	if in.Principals != nil {
		in, out := &in.Principals, &out.Principals
		*out = make([]*Principal, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Principal)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.Resources != nil {
		in, out := &in.Resources, &out.Resources
		*out = make([]*Resource, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Resource)
				**out = **in
			}
		}
	}
	if in.Permissions != nil {
		in, out := &in.Permissions, &out.Permissions
		*out = make([]*Permission, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Permission)
				**out = **in
			}
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RamParameters.
func (in *RamParameters) DeepCopy() *RamParameters {
	if in == nil {
		return nil
	}
	out := new(RamParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ResourceAccessManager) DeepCopyInto(out *ResourceAccessManager) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ResourceAccessManager.
func (in *ResourceAccessManager) DeepCopy() *ResourceAccessManager {
	if in == nil {
		return nil
	}
	out := new(ResourceAccessManager)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ResourceAccessManager) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ResourceAccessManagerList) DeepCopyInto(out *ResourceAccessManagerList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]ResourceAccessManager, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ResourceAccessManagerList.
func (in *ResourceAccessManagerList) DeepCopy() *ResourceAccessManagerList {
	if in == nil {
		return nil
	}
	out := new(ResourceAccessManagerList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ResourceAccessManagerList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ResourceAccessManagerSpec) DeepCopyInto(out *ResourceAccessManagerSpec) {
	*out = *in
	in.RamParameters.DeepCopyInto(&out.RamParameters)
	if in.AllowExternalPrincipals != nil {
		in, out := &in.AllowExternalPrincipals, &out.AllowExternalPrincipals
		*out = new(bool)
		**out = **in
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ResourceAccessManagerSpec.
func (in *ResourceAccessManagerSpec) DeepCopy() *ResourceAccessManagerSpec {
	if in == nil {
		return nil
	}
	out := new(ResourceAccessManagerSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ResourceAccessManagerStatus) DeepCopyInto(out *ResourceAccessManagerStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ResourceAccessManagerStatus.
func (in *ResourceAccessManagerStatus) DeepCopy() *ResourceAccessManagerStatus {
	if in == nil {
		return nil
	}
	out := new(ResourceAccessManagerStatus)
	in.DeepCopyInto(out)
	return out
}
