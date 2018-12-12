#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

# Check prometheus rules
find . -name 'rules.yml' | \
while read ruleFile; do
  echo "------------- CHECKING PROMETHEUS RULES IN $ruleFile ---------"
  yq r "$ruleFile" spec |  promtool check rules /dev/stdin
done

# for dir in $(find . -type d -maxdepth 1 -mindepth 1 -not -path "./.git");
# do
#     pushd $dir
#     echo "------------- RUNNING TESTS INTO $dir ---------"
#     kustomize build > /dev/null
#     kustomize build | kube-score --ignore-test=ScoreServiceTargetsPod -
#     popd
# done
