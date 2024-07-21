# RDS Base composition

This needs

- provider-aws-rds
- provider-sql
- external secrets operator

### External Secrets Operator

This tool is required to duplicate the connection secret out to a format that is
readable by provider-sql

When creating a aurora-postgresql cluster, it was noted that the master username
and master password were stored in the secret as `master_username` and `attribute.master_password`
respectively.

Normal instances do not have this issue and are stored as `username` and `password`
This causes an issue for `provider-sql` which expects just `username` and `password`

To resolve this, ESO is brought into the equation to securely copy the connection
secret and set it up for provider-sql in the required format

For ESO to work, the following must exist in the namespace used by the claim:

- service-account
- role
- rolebinding
- secretstore

#### Example

```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: null
  name: my-store
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: eso-store-role
rules:
- apiGroups: [""]
  resources:
  - secrets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - authorization.k8s.io
  resources:
  - selfsubjectrulesreviews
  verbs:
  - create
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: null
  name: my-store
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: eso-store-role
subjects:
- kind: ServiceAccount
  name: my-store
  namespace: default
---
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: default
  namespace: default
spec:
  provider:
    kubernetes:
      # with this, the store is able to pull only from `default` namespace
      remoteNamespace: default
      server:
        caProvider:
          type: ConfigMap
          name: kube-root-ca.crt
          key: ca.crt
      auth:
        serviceAccount:
          name: "my-store"
```
