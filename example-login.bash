PGPASSWORD="$(kubectl get secret cloudtest-cluster-tgw-rds-master -o yaml | yq '.data.password | @base64d')"
PGHOST="$(kubectl get secret cloudtest-cluster-tgw-rds-master -o yaml | yq '.data.endpoint | @base64d')"

kubectl exec -it postgresql-client -- psql postgresql://giantswarm:"${PGPASSWORD}@${PGHOST}:5432/postgres"
