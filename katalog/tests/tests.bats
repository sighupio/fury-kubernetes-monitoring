#!/usr/bin/env bats

test_apply() {
  kubectl get nodes >&3
  pwd >&3
  ls >&3
  e=0
  for el in $DIRS; do
      echo "# applying $el" >&3
      kustomize build $BASEDIR/$el | (kubectl apply -f -) 2>&1 >&3 || e=$? && echo "# e=$e" >&3
  done
  kubectl get all --all-namespaces >&3
  return $e
}

@test "testing apply to cluster" {
  run test_apply
  [ "$status" -eq 0 ]
}
