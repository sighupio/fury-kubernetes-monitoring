#!/usr/bin/env bats

test_apply() {
  e=0
  for el in $DIRS; do
      echo "# applying $el" >&3
      kustomize build $BASEDIR/$el | kubectl apply -f - || e=$? && echo "# e=$e" >&3
  done
  return $e
}

@test "testing apply to cluster" {
  run test_apply
  [ "$status" -eq 0 ]
}
