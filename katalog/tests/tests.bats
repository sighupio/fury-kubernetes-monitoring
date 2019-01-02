#!/usr/bin/env bats

@test "testing prometheus-operator apply" {
  kustomize build prometheus-operator | kubectl apply -f - && kustomize build prometheus-operator | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing kube-state-metrics apply" {
  kustomize build kube-state-metrics | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing node-exporter apply" {
  kustomize build node-exporter | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing alertmanager-operated apply" {
  kustomize build alertmanager-operated | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing grafana apply" {
  kustomize build grafana | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing kubeadm-sm apply" {
  kustomize build kubeadm-sm | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing prometheus-operated apply" {
  kustomize build prometheus-operated | kubectl apply -f -
  [ "$status" -eq 0 ]
}
