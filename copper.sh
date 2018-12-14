#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

for dir in $(find . -type d -maxdepth 1 -mindepth 1 -not -path "./.git" -not -path "./prometheus-operator" -not -path "./examples");
do
    pushd $dir
    echo "------------- RUNNING TESTS INTO $dir ---------"
    kustomize build > /dev/null
    TMPFILE=$(mktemp)
    kustomize build > $TMPFILE
    copper check --rules ../rules.cop --file $TMPFILE
    rm $TMPFILE
    popd
done