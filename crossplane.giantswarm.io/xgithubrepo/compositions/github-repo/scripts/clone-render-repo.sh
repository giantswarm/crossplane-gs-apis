#!/bin/bash
set -e

# Added function for logging with timestamps
log() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $*"
}

log "Starting script"
# Check that all required environment variables are set
for var in GITHUB_TOKEN REPO_OWNER REPO_NAME REGISTRY_DOMAIN BACKSTAGE_ENTITY_OWNER BACKSTAGE_ENTITY_LIFECYCLE REPO_DESCRIPTION REPO_VISIBILITY REPO_TEMPLATE_SOURCE; do
	if [ -z "${!var:-}" ]; then
		echo "Error: $var is not set."
		exit 1
	fi
done

log "Starting clone and render pipeline"

cd /tmp
# Create and clone repository using gh CLI
log "Checking if repository ${REPO_OWNER}/${REPO_NAME} exists"
REPO_INFO=$(gh repo view "${REPO_OWNER}/${REPO_NAME}" --json owner,name,visibility 2>/dev/null || echo "{}")
if jq -e . >/dev/null 2>&1 <<<"$REPO_INFO" && [ "$(jq -r '.name' <<<"$REPO_INFO")" != "null" ]; then
	log "Repository ${REPO_OWNER}/${REPO_NAME} already exists, checking configuration"

	REPO_OWNER_ACTUAL=$(echo "$REPO_INFO" | jq -r '.owner.login')
	REPO_NAME_ACTUAL=$(echo "$REPO_INFO" | jq -r '.name')
	REPO_VISIBILITY_ACTUAL=$(echo "$REPO_INFO" | jq -r '.visibility')

	if [ "$REPO_OWNER_ACTUAL" != "$REPO_OWNER" ]; then
		log "Error: Repository owner does not match. Expected: ${REPO_OWNER}, Actual: ${REPO_OWNER_ACTUAL}"
		exit 1
	fi

	if [ "$REPO_NAME_ACTUAL" != "$REPO_NAME" ]; then
		log "Error: Repository name does not match. Expected: ${REPO_NAME}, Actual: ${REPO_NAME_ACTUAL}"
		exit 1
	fi

	REPO_VISIBILITY_EXPECTED=$(echo "$REPO_VISIBILITY" | tr '[:lower:]' '[:upper:]')
	if [ "$REPO_VISIBILITY_ACTUAL" != "$REPO_VISIBILITY_EXPECTED" ]; then
		log "Error: Repository visibility does not match. Expected: ${REPO_VISIBILITY}, Actual: ${REPO_VISIBILITY_ACTUAL}"
		exit 1
	fi

	log "Repository ${REPO_OWNER}/${REPO_NAME} already exists and configuration matches, skipping creation"
else
	log "Creating repository ${REPO_OWNER}/${REPO_NAME} using gh CLI"
	gh repo create "${REPO_OWNER}/${REPO_NAME}" -d "${REPO_DESCRIPTION}" "--${REPO_VISIBILITY}" -p "${REPO_TEMPLATE_SOURCE}" || true
	#FIXME: github is a bit slow sometimes and the created repo can be empty if cloned immediately
	sleep 2
fi
# Change directory: assume local folder is the same as repo name
rm -rf "${REPO_NAME}" || true
gh auth setup-git
gh repo clone "${REPO_OWNER}/${REPO_NAME}" 2>&1
cd "${REPO_NAME}"

# Check if repository was initialized
GIT_LOG_INIT_MESSAGE="Initial commit: fill in template values"
git_out=$(git log --grep "^${GIT_LOG_INIT_MESSAGE}\$")
if [[ -n "$git_out" ]]; then
	log "Repository was already initialized"
	exit 0
else
	log "Repository wasn't initialized, proceeding with templating."
fi

# Template processing (same as previous logic)
log "Preparing template files."
NEW_PATH=$(mktemp -d)
cp -a "./project-template/" "$NEW_PATH/"

cat >"$NEW_PATH/boilerplate-values.yml" <<EOF
BackstageEntityOwner: ${BACKSTAGE_ENTITY_OWNER}
BackstageEntityLifecycle: ${BACKSTAGE_ENTITY_LIFECYCLE}
ProjectName: ${REPO_NAME}
RepoOwner: ${REPO_OWNER}
ImageName: ${REPO_NAME}
RegistryDomain: ${REGISTRY_DOMAIN}
RegistryName: ${REPO_OWNER}
EOF

# Remove all tracked files before rendering
git rm -r '*' || true

log "Running boilerplate command to render template"
boilerplate --non-interactive --template-url "$NEW_PATH"/project-template --output-folder . --var-file "$NEW_PATH"/boilerplate-values.yml

# Stage and commit changes
git add -A
set +e
log "Running pre-commit hooks"
pre-commit run -a
set -e
git add -A

git config user.email "giant-idp@bots.github.com"
git config user.name "Giant IDP Bot"
log "Commit all the changes"
git commit -am "$GIT_LOG_INIT_MESSAGE"

log "Pushing changes to main branch"
git remote show origin
git push origin main
git tag -m "Initial release" "0.1.0"
git push origin "0.1.0"

git push origin main

log "Pipeline finished successfully"
