#!/usr/bin/env bats

@test "testing prometheus-operator apply" {
  kustomize build katalog/prometheus-operator | kubectl apply -f - || kustomize build katalog/prometheus-operator | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing kube-state-metrics apply" {
  kustomize build katalog/kube-state-metrics | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing node-exporter apply" {
  kustomize build katalog/node-exporter | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing alertmanager-operated apply" {
  kustomize build katalog/alertmanager-operated | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing grafana apply" {
  kustomize build katalog/grafana | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing kubeadm-sm apply" {
  kustomize build katalog/kubeadm-sm | kubectl apply -f -
  [ "$status" -eq 0 ]
}

@test "testing prometheus-operated apply" {
  kustomize build katalog/prometheus-operated | kubectl apply -f -
  [ "$status" -eq 0 ]
}
