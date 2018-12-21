#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

find . -type f \
  -name 'kustomization.yaml' \
  -not -path './examples/*' | \
sort | \
xargs dirname | \
while read dir; do
    echo "------------- RUNNING TESTS INTO $dir ---------"
    kustomize build "$dir" > /dev/null
    set +e
    kustomize build "$dir" | pytest -svv --disable-pytest-warnings katalog/tests/test.py
    set -e
done

exit 0
