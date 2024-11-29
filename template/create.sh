#!/bin/bash

BASE_PATH="crossplane.giantswarm.io"

RED=$(echo $'\033[31m');
GREEN=$(echo $'\033[32m');
YELLOW=$(echo $'\033[33m');
BLUE=$(echo $'\033[34m');
MAGENTA=$(echo $'\033[35m');
CYAN=$(echo $'\033[36m');
WHITE=$(echo $'\033[37m');

RESET=$(echo $'\033[00m');

BOLD=$(tput bold);
NORMAL=$(tput sgr0)

function inform()
{
    if [ "$1" = '-n' ] ; then
        shift
        echo -n "$WHITE[INFO]$RESET $@" 1>&2;
    else
        echo "$WHITE[INFO]$RESET $@" 1>&2;
    fi
}

function question()
{
    local message="$@"
    shift
    inform -n "$message > "
    read answer
    if [ -z $answer ]; then
        answer=$(question "$message")
    fi
    echo $answer
}

moduleroot ()
{
    local wd="$(pwd)";
    while [ ! -d ".git" ] && [ "$(pwd)" != "/" ]; do
        cd ..;
    done;
    local moduleName=$(basename `pwd`);
    if [ "$moduleName" = "/" ]; then
        error "Cannot find root directory for current module. Are you sure it's a git repository?" 1>&2;
        cd "$wd";
        return 1;
    fi;
    return 0
}

moduleroot || exit 1

GROUP_NAME=$(question "Enter the group name" | tr '[:upper:]' '[:lower:]')
COMPOSITION=$(question "Enter the composition name (lowercase, hyphenated)")
GROUP_CLASS=$(question "Enter the group class (camel-cased struct name)")

# Make sure at least the first letter is uppercase so go can export it
GROUP_CLASS="${GROUP_CLASS^}"
group_class_lower=$(tr '[:upper:]' '[:lower:]' <<< $GROUP_CLASS)

inform "creating directories"
mkdir -p ${BASE_PATH}/${GROUP_NAME}/{compositions/${COMPOSITION}/templates,v1alpha1,docs,examples}

inform "templating generate.go"
sed -e "s|<GROUP_NAME>|${GROUP_NAME}|g" \
    template/files/generate.go.tpl > ${BASE_PATH}/${GROUP_NAME}/generate.go

inform "templating main.go"

sed -e "s|<GROUP_NAME>|${GROUP_NAME}|g" \
    -e "s|<GROUP_CLASS>|${GROUP_CLASS}|g" \
    -e "s|<COMPOSITION>|${COMPOSITION}|g" \
     template/files/main.go.tpl > ${BASE_PATH}/${GROUP_NAME}/compositions/${COMPOSITION}/main.go

if [ ! -f ${BASE_PATH}/${GROUP_NAME}/v1alpha1/doc.go ]; then
    inform "templating doc.go"
    sed -e "s|<GROUP_NAME>|${GROUP_NAME}|g" \
        template/files/doc.go.tpl > ${BASE_PATH}/${GROUP_NAME}/v1alpha1/doc.go
fi

if [ ! -f ${BASE_PATH}/${GROUP_NAME}/v1alpha1/groupversion.go ]; then
    inform "templating groupversion.go"
    sed -e "s|<GROUP_NAME>|${GROUP_NAME}|g" -e "s|<GROUP_CLASS>|${GROUP_CLASS}|g" \
        template/files/groupversion.go.tpl > ${BASE_PATH}/${GROUP_NAME}/v1alpha1/groupversion.go
else
    if ! grep -q "${GROUP_CLASS}List" ${BASE_PATH}/${GROUP_NAME}/v1alpha1/groupversion.go; then
        inform "updating groupversion.go"
        schema="SchemeBuilder.Register(\&${GROUP_CLASS}\{\}, \&${GROUP_CLASS}List\{\})"
        sed -i "s|func init() {|func init() {\n\t$schema|" ${BASE_PATH}/${GROUP_NAME}/v1alpha1/groupversion.go
    fi
fi

if [ ! -f "${BASE_PATH}/${GROUP_NAME}/v1alpha1/${group_class_lower}_types.go" ]; then
    SHORTNAME=$(question "Enter a shortname for the XRD type" | tr '[:upper:]' '[:lower:]')
    ENFORCE_COMPOSITION=$(question "Enforce composition? (yes/no)" | tr '[:upper:]' '[:lower:]')
    sed -e "s|<GROUP_NAME>|${GROUP_NAME}|g" \
        -e "s|<GROUP_CLASS>|${GROUP_CLASS}|g" \
        -e "s|<SHORTNAME>|${SHORTNAME}|g" \
        -e "s|<COMPOSITION>|${COMPOSITION}|g" \
        template/files/xrd.go.tpl > ${BASE_PATH}/${GROUP_NAME}/v1alpha1/${group_class_lower}_types.go

    if [ "$ENFORCE_COMPOSITION" = "no" ]; then
        sed -i '/.*enforcedCompositionRef.*/d' ${BASE_PATH}/${GROUP_NAME}/v1alpha1/${group_class_lower}_types.go
    fi
fi

make