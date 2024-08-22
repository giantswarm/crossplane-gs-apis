PGPASSWORD="$(kubectl get secret test-logical-database-rds-user -o yaml | yq '.data.password | @base64d')"
PGHOST="$(kubectl get secret test-logical-database-rds-user -o yaml | yq '.data.endpoint | @base64d')"

kubectl exec -it mysql-client -- mysql -u test-logical-database -p${PGPASSWORD} -h ${PGHOST} -P 3306 test-logical-database
