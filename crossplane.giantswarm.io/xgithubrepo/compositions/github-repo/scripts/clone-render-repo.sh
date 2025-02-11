set -euo pipefail

# Parameters
REPO_OWNER="demotechinc"
REPO_NAME="laszlo-crossplane-provider-github"

REGISTRY_DOMAIN="ghcr.io"

BACKSTAGE_ENTITY_OWNER="exampleBackstageEntityOwner"
BACKSTAGE_ENTITY_LIFECYCLE="exampleBackstageEntityLifecycle"

# Clone repository
TMP_DIR=$(mktemp -d)

git clone "https://${GITHUB_TOKEN}@github.com/${REPO_OWNER}/${REPO_NAME}.git" "${TMP_DIR}" 2>&1

cd ${TMP_DIR}

# Do not render if the repository was modified beyond the 1st commit that created it from the template repository
NUMBER_OF_COMMITS=$(git rev-list --count HEAD)

if [ "${NUMBER_OF_COMMITS}" != "1" ]; then
  echo "Repository was already modified beyond the 1st commit, bailing out."
  exit 0
else
  # Template repository
  NEW_PATH=$(mktemp -d)

  cp -a ${TMP_DIR}/project-template/ $NEW_PATH/

  cat >$NEW_PATH/boilerplate-values.yml <<EOF
BackstageEntityOwner: ${BACKSTAGE_ENTITY_OWNER}
BackstageEntityLifecycle: ${BACKSTAGE_ENTITY_LIFECYCLE}
ProjectName: ${REPO_NAME}
RepoOwner: ${REPO_OWNER}
ImageName: ${REPO_NAME}
RegistryDomain: ${REGISTRY_DOMAIN}
RegistryName: ${REPO_OWNER}
EOF

  git rm -r '*'

  boilerplate --non-interactive --template-url "$NEW_PATH"/project-template --output-folder . --var-file "$NEW_PATH"/boilerplate-values.yml

  git config user.email "crossplane@bots.github.com"
  git config user.name "Crossplane Bot"

  # git push -d origin laszlo-test-1
  # git branch -d laszlo-test-1

  # git checkout -b laszlo-test-1 2>&1

  git add -A

  git commit -am "Laszlo was here"

  # git push origin laszlo-test-1 || true
  git push origin main
fi