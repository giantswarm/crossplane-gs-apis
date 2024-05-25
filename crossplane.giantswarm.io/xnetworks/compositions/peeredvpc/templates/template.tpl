#
# Wait for the claim name to be populated before setting the appName
#
{{ $appName := "" }}
{{ $claimRef := .observed.composite.resource.spec.claimRef }}
{{ if not ( empty $claimRef ) }}
    {{ $appName = index $claimRef "name" }}
{{ end }}

#
# Common information required from the composite
#
{{ $labels := .observed.composite.resource.metadata.labels }}
{{ $region  := .observed.composite.resource.spec.region }}
{{ $subnets := .observed.composite.resource.spec.subnets }}
{{ $tags := .observed.composite.resource.spec.tags }}
{{ $zones := .observed.composite.resource.spec.subnets.zones }}
{{ $dp := .observed.composite.resource.spec.deletionPolicy }}


# Set up a new list and copy the subnets into it preserving the 3x3 offsets
{{ $ssCidrs = list 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 }}
{{ $_, $v := range $subnets.cidrBlocks }}
{{ $ssCidrs = set $ssCidrs $v }}
{{ end }}

{{ $ssCidrs = slice $subnets.cidrBlocks 0 3 }}
{{ $ssCidrs = append $ssCidrs (slice $subnets.cidrBlocks 3 6) }}
{{ $ssCidrs = append $ssCidrs (slice $subnets.cidrBlocks 6 9) }}

{{ $ssZones = list


#
# Create public and private subnet sets
#
{{ $types := list "public" "private" }}
{{ $zoneLen := len $zones }}

{{ $maxSubnets := list 1 2 3 }}

{{ range $num := $maxSubnets }}
#
# Create one subnet set for each type (public / private)
{{ range $type := $types }}

    # Public subnets are the first 3 in the Cidr list from the claim
    {{ $cidrs := slice $subnets.cidrBlocks 0 $zoneLen }}
    {{ if eq $type "private" }}
        {{ $cidrs = slice $subnets.cidrBlocks $zoneLen (len $subnets.cidrBlocks) }}
    {{ end }}
#
#  Create SubnetSet for {{ $type }} subnets
---
apiVersion: xnetworks.crossplane.giantswarm.io/v1alpha1
kind: SubnetSet
metadata:
annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $type }}-subnets-{{ $num }}
labels:
    {{range $key, $value := $labels }}
    {{ $key }}: {{ $value }}
    {{ end }}
    visibility: {{ $type }}
name: {{ $appName }}-{{ $type }}-{{ $num }}
spec:
claimRef:
{{ range $key, $value := $claimRef }}
    {{ $key }}: {{ $value }}
{{ end }}
deletionPolicy: {{ $dp }}
region: {{ $region }}
subnets:
    a:
    zone: {{ index $zones 0 }}
    cidrBlock: {{ index $cidrs 0 }}
    b:
    zone: {{ index $zones 1 }}
    cidrBlock: {{ index $cidrs 1 }}
    c:
    zone: {{ index $zones 2 }}
    cidrBlock: {{ index $cidrs 2 }}
type: {{ $type }}
tags:
{{ range $key, $value := $tags }}
    {{ $key }}: {{ $value }}
{{ end }}
{{ end }} # end range $types
{{ end }} # end range maxSubnets

#
# Create nat gateways and elastic ips
#
{{ $index := 0 }}
{{ $pubsubs := .observed.composite.resource.status.publicSubnets }}
{{ $pubrtbls := .observed.composite.resource.status.publicRouteTables }}
{{ $prirtbls := .observed.composite.resource.status.privateRouteTables }}
{{ $igwId := .observed.composite.resource.status.igwId }}

# Create EIP, NAT Gateway, and Route for each zone
{{ range $k, $v := $zones }}
    {{ $az := printf "%s%s" $region $v }}
    {{ $pubsn := "" }}
    {{ $prirtbl := "" }}
    {{ $pubrtbl := "" }}

    # Get the public subnet ids when all 3 are created
    {{ if not (empty $pubsubs) }}
        {{ if eq (len (keys $pubsubs)) $zoneLen }}
            {{ $pubsn = get $pubsubs (index ( keys $pubsubs | sortAlpha ) $k) }}
        {{ end }}
    {{ end }}

    # Get the private route table ids when all 3 are created
    {{ if not (empty $prirtbls) }}
        {{ if eq (len ( keys $prirtbls )) $zoneLen }}
            {{ $prirtbl = get $prirtbls (index ( keys $prirtbls | sortAlpha ) $k) }}
        {{ end }}
    {{ end }}

    # Get the public route table ids when all 3 are created
    {{ if not (empty $pubrtbls) }}
        {{ if eq (len (keys $pubrtbls )) $zoneLen }}
            {{ $pubrtbl = get $pubrtbls (index ( keys $pubrtbls | sortAlpha ) $k) }}
        {{ end }}
    {{ end }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: EIP
metadata:
annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: eip-{{ $index }}
name: {{ $appName }}-ngw-{{ $az }}
labels:
    availabilityZone: {{ $az }}
    utilization: nat-gateway
spec:
forProvider:
    region: {{ $region }}
    domain: vpc
    tags:
    Name: {{ $appName }}-{{ $az }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: NATGateway
metadata:
annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: nat-gateway-{{ $index }}
name: {{ $appName }}-{{ $az }}
labels:
    availabilityZone: {{ $az }}
spec:
forProvider:
    region: {{ $region }}
    allocationIdSelector:
    matchControllerRef: true
    matchLabels:
        availabilityZone: {{ $az }}
    subnetId: {{ if not (empty $pubsn) }}{{ $pubsn }}{{ end }}
    tags:
    Name: {{ $appName }}-{{ $az }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: Route
metadata:
annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: ngw-route-{{ $index }}
name: {{ $appName }}-ngw-{{ $az }}
labels:
    availabilityZone: {{ $az }}
spec:
forProvider:
    destinationCidrBlock: 0.0.0.0/0
    natGatewayIdSelector:
    matchControllerRef: true
    matchLabels:
        availabilityZone: {{ $az }}
    routeTableId: {{ if not (empty $prirtbl) }}{{ $prirtbl }}{{ end }}
    region: {{ $region }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: Route
metadata:
annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: igw-route-{{ $index }}
name: {{ $appName }}-igw-{{ $az }}
labels:
    availabilityZone: {{ $az }}
spec:
forProvider:
    destinationCidrBlock: 0.0.0.0/0
    gatewayIdSelector:
    matchControllerRef: true
    routeTableId: {{ if not (empty $pubrtbl) }}{{ $pubrtbl }}{{ end }}
    region: {{ $region }}
{{ $index = add $index 1 }}
{{ end }} # end range $zones