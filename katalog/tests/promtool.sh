#!/usr/bin/env bash

# set -x
set -e
set -u
set -o pipefail

# Check prometheus rules
find . -name 'rules.yml' | \
while read -r rules_file; do
  echo "------------- CHECKING PROMETHEUS RULES IN $rules_file ---------"
  yq r "$rules_file" spec | promtool check rules /dev/stdin
done
