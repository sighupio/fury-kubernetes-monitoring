#!/usr/bin/env bats

apply (){
  kustomize build $1 | kubectl apply -f -
}

@test "testing prometheus-operator apply" {
  apply katalog/prometheus-operator
  run apply katalog/prometheus-operator
  [ "$status" -eq 0 ]
}

@test "testing kube-state-metrics apply" {
  run apply katalog/kube-state-metrics
  [ "$status" -eq 0 ]
}

@test "testing node-exporter apply" {
  run apply katalog/node-exporter
  [ "$status" -eq 0 ]
}

@test "testing alertmanager-operated apply" {
  run apply katalog/alertmanager-operated
  [ "$status" -eq 0 ]
}

@test "testing grafana apply" {
  run apply katalog/grafana
  [ "$status" -eq 0 ]
}

@test "testing kubeadm-sm apply" {
  run apply katalog/kubeadm-sm
  [ "$status" -eq 0 ]
}

@test "testing prometheus-operated apply" {
  run apply katalog/prometheus-operated
  [ "$status" -eq 0 ]
}
