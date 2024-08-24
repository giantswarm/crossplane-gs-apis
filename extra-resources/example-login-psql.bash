SECRETNAME=demotech-rcc-rds-user
PGPASSWORD="$(kubectl get secret ${SECRETNAME} -o yaml | yq '.data.password | @base64d')"
PGHOST="$(kubectl get secret ${SECRETNAME} -o yaml | yq '.data.endpoint | @base64d')"
PGUSER="$(kubectl get secret ${SECRETNAME} -o yaml | yq '.data.username | @base64d')"

kubectl exec -it postgresql-client -- psql postgresql://"${PGUSER}":"${PGPASSWORD}@${PGHOST}:5432/${PGUSER}"
