#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

# Check prometheus rules
find . -name 'rules.yml' | \
while read ruleFile; do
  echo "------------- CHECKING PROMETHEUS RULES IN $ruleFile ---------"
  yq r "$ruleFile" spec | promtool check rules /dev/stdin
done
