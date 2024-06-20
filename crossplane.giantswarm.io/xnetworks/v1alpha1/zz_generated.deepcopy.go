//go:build !ignore_autogenerated

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	compositev1beta1 "github.com/giantswarm/crossplane-fn-network-discovery/pkg/composite/v1beta1"
	"github.com/mproffitt/function-cidr/input/v1beta1"
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredSubnetBuilder) DeepCopyInto(out *PeeredSubnetBuilder) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredSubnetBuilder.
func (in *PeeredSubnetBuilder) DeepCopy() *PeeredSubnetBuilder {
	if in == nil {
		return nil
	}
	out := new(PeeredSubnetBuilder)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredSubnetSet) DeepCopyInto(out *PeeredSubnetSet) {
	*out = *in
	out.Public = in.Public
	out.Private = in.Private
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredSubnetSet.
func (in *PeeredSubnetSet) DeepCopy() *PeeredSubnetSet {
	if in == nil {
		return nil
	}
	out := new(PeeredSubnetSet)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredSubnets) DeepCopyInto(out *PeeredSubnets) {
	*out = *in
	if in.Cidrs != nil {
		in, out := &in.Cidrs, &out.Cidrs
		*out = make([]PeeredSubnetSet, len(*in))
		copy(*out, *in)
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredSubnets.
func (in *PeeredSubnets) DeepCopy() *PeeredSubnets {
	if in == nil {
		return nil
	}
	out := new(PeeredSubnets)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcNetwork) DeepCopyInto(out *PeeredVpcNetwork) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcNetwork.
func (in *PeeredVpcNetwork) DeepCopy() *PeeredVpcNetwork {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcNetwork)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *PeeredVpcNetwork) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcNetworkList) DeepCopyInto(out *PeeredVpcNetworkList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]PeeredVpcNetwork, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcNetworkList.
func (in *PeeredVpcNetworkList) DeepCopy() *PeeredVpcNetworkList {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcNetworkList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *PeeredVpcNetworkList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcNetworkParameters) DeepCopyInto(out *PeeredVpcNetworkParameters) {
	*out = *in
	in.PeeredSubnets.DeepCopyInto(&out.PeeredSubnets)
	in.Tags.DeepCopyInto(&out.Tags)
	in.Peering.DeepCopyInto(&out.Peering)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcNetworkParameters.
func (in *PeeredVpcNetworkParameters) DeepCopy() *PeeredVpcNetworkParameters {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcNetworkParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcNetworkSpec) DeepCopyInto(out *PeeredVpcNetworkSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
	if in.AvailabilityZones != nil {
		in, out := &in.AvailabilityZones, &out.AvailabilityZones
		*out = make([]string, len(*in))
		copy(*out, *in)
	}
	in.PeeredVpcNetworkParameters.DeepCopyInto(&out.PeeredVpcNetworkParameters)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcNetworkSpec.
func (in *PeeredVpcNetworkSpec) DeepCopy() *PeeredVpcNetworkSpec {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcNetworkSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcNetworkStatus) DeepCopyInto(out *PeeredVpcNetworkStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
	if in.CalculatedCidrs != nil {
		in, out := &in.CalculatedCidrs, &out.CalculatedCidrs
		*out = make(map[string][]string, len(*in))
		for key, val := range *in {
			var outVal []string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = make([]string, len(*in))
				copy(*out, *in)
			}
			(*out)[key] = outVal
		}
	}
	if in.SubnetBits != nil {
		in, out := &in.SubnetBits, &out.SubnetBits
		*out = make([]v1beta1.MultiPrefix, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	if in.Vpcs != nil {
		in, out := &in.Vpcs, &out.Vpcs
		*out = make(map[string]compositev1beta1.Vpc, len(*in))
		for key, val := range *in {
			(*out)[key] = *val.DeepCopy()
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcNetworkStatus.
func (in *PeeredVpcNetworkStatus) DeepCopy() *PeeredVpcNetworkStatus {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcNetworkStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PeeredVpcTags) DeepCopyInto(out *PeeredVpcTags) {
	*out = *in
	if in.Common != nil {
		in, out := &in.Common, &out.Common
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.Subnet != nil {
		in, out := &in.Subnet, &out.Subnet
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.Cluster != nil {
		in, out := &in.Cluster, &out.Cluster
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PeeredVpcTags.
func (in *PeeredVpcTags) DeepCopy() *PeeredVpcTags {
	if in == nil {
		return nil
	}
	out := new(PeeredVpcTags)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSet) DeepCopyInto(out *SubnetSet) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSet.
func (in *SubnetSet) DeepCopy() *SubnetSet {
	if in == nil {
		return nil
	}
	out := new(SubnetSet)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *SubnetSet) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetList) DeepCopyInto(out *SubnetSetList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]SubnetSet, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetList.
func (in *SubnetSetList) DeepCopy() *SubnetSetList {
	if in == nil {
		return nil
	}
	out := new(SubnetSetList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *SubnetSetList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetParameters) DeepCopyInto(out *SubnetSetParameters) {
	*out = *in
	in.Tags.DeepCopyInto(&out.Tags)
	out.Subnets = in.Subnets
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetParameters.
func (in *SubnetSetParameters) DeepCopy() *SubnetSetParameters {
	if in == nil {
		return nil
	}
	out := new(SubnetSetParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetSpec) DeepCopyInto(out *SubnetSetSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
	in.SubnetSetParameters.DeepCopyInto(&out.SubnetSetParameters)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetSpec.
func (in *SubnetSetSpec) DeepCopy() *SubnetSetSpec {
	if in == nil {
		return nil
	}
	out := new(SubnetSetSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetStatus) DeepCopyInto(out *SubnetSetStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
	out.Subnets = in.Subnets
	out.RouteTables = in.RouteTables
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetStatus.
func (in *SubnetSetStatus) DeepCopy() *SubnetSetStatus {
	if in == nil {
		return nil
	}
	out := new(SubnetSetStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetStatusRouteTable) DeepCopyInto(out *SubnetSetStatusRouteTable) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetStatusRouteTable.
func (in *SubnetSetStatusRouteTable) DeepCopy() *SubnetSetStatusRouteTable {
	if in == nil {
		return nil
	}
	out := new(SubnetSetStatusRouteTable)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetStatusSubnet) DeepCopyInto(out *SubnetSetStatusSubnet) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetStatusSubnet.
func (in *SubnetSetStatusSubnet) DeepCopy() *SubnetSetStatusSubnet {
	if in == nil {
		return nil
	}
	out := new(SubnetSetStatusSubnet)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetSubnet) DeepCopyInto(out *SubnetSetSubnet) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetSubnet.
func (in *SubnetSetSubnet) DeepCopy() *SubnetSetSubnet {
	if in == nil {
		return nil
	}
	out := new(SubnetSetSubnet)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SubnetSetSubnets) DeepCopyInto(out *SubnetSetSubnets) {
	*out = *in
	out.SubnetA = in.SubnetA
	out.SubnetB = in.SubnetB
	out.SubnetC = in.SubnetC
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SubnetSetSubnets.
func (in *SubnetSetSubnets) DeepCopy() *SubnetSetSubnets {
	if in == nil {
		return nil
	}
	out := new(SubnetSetSubnets)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Subnets) DeepCopyInto(out *Subnets) {
	*out = *in
	if in.CidrBlocks != nil {
		in, out := &in.CidrBlocks, &out.CidrBlocks
		*out = make([]Cidr, len(*in))
		copy(*out, *in)
	}
	if in.Zones != nil {
		in, out := &in.Zones, &out.Zones
		*out = make([]string, len(*in))
		copy(*out, *in)
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Subnets.
func (in *Subnets) DeepCopy() *Subnets {
	if in == nil {
		return nil
	}
	out := new(Subnets)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *TagSet) DeepCopyInto(out *TagSet) {
	*out = *in
	if in.All != nil {
		in, out := &in.All, &out.All
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.Subnet != nil {
		in, out := &in.Subnet, &out.Subnet
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new TagSet.
func (in *TagSet) DeepCopy() *TagSet {
	if in == nil {
		return nil
	}
	out := new(TagSet)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcNetwork) DeepCopyInto(out *VpcNetwork) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcNetwork.
func (in *VpcNetwork) DeepCopy() *VpcNetwork {
	if in == nil {
		return nil
	}
	out := new(VpcNetwork)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *VpcNetwork) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcNetworkList) DeepCopyInto(out *VpcNetworkList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]VpcNetwork, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcNetworkList.
func (in *VpcNetworkList) DeepCopy() *VpcNetworkList {
	if in == nil {
		return nil
	}
	out := new(VpcNetworkList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *VpcNetworkList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcNetworkParameters) DeepCopyInto(out *VpcNetworkParameters) {
	*out = *in
	in.Tags.DeepCopyInto(&out.Tags)
	in.Subnets.DeepCopyInto(&out.Subnets)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcNetworkParameters.
func (in *VpcNetworkParameters) DeepCopy() *VpcNetworkParameters {
	if in == nil {
		return nil
	}
	out := new(VpcNetworkParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcNetworkSpec) DeepCopyInto(out *VpcNetworkSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
	in.VpcNetworkParameters.DeepCopyInto(&out.VpcNetworkParameters)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcNetworkSpec.
func (in *VpcNetworkSpec) DeepCopy() *VpcNetworkSpec {
	if in == nil {
		return nil
	}
	out := new(VpcNetworkSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcNetworkStatus) DeepCopyInto(out *VpcNetworkStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
	in.Vpc.DeepCopyInto(&out.Vpc)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcNetworkStatus.
func (in *VpcNetworkStatus) DeepCopy() *VpcNetworkStatus {
	if in == nil {
		return nil
	}
	out := new(VpcNetworkStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcPeer) DeepCopyInto(out *VpcPeer) {
	*out = *in
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcPeer.
func (in *VpcPeer) DeepCopy() *VpcPeer {
	if in == nil {
		return nil
	}
	out := new(VpcPeer)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcPeering) DeepCopyInto(out *VpcPeering) {
	*out = *in
	if in.RemoteVpcs != nil {
		in, out := &in.RemoteVpcs, &out.RemoteVpcs
		*out = make([]VpcPeer, len(*in))
		copy(*out, *in)
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcPeering.
func (in *VpcPeering) DeepCopy() *VpcPeering {
	if in == nil {
		return nil
	}
	out := new(VpcPeering)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *VpcTags) DeepCopyInto(out *VpcTags) {
	*out = *in
	if in.Common != nil {
		in, out := &in.Common, &out.Common
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.PublicSubnetTags != nil {
		in, out := &in.PublicSubnetTags, &out.PublicSubnetTags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.PrivateSubnetTags != nil {
		in, out := &in.PrivateSubnetTags, &out.PrivateSubnetTags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new VpcTags.
func (in *VpcTags) DeepCopy() *VpcTags {
	if in == nil {
		return nil
	}
	out := new(VpcTags)
	in.DeepCopyInto(out)
	return out
}
