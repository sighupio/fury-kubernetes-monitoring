#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


load ./helper

@test "Applying ServiceMonitor CRDs" {
  info
  setup() {
    kubectl apply --server-side -f katalog/prometheus-operator/crds/0servicemonitorCustomResourceDefinition.yaml
  }
  loop_it setup 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy prometheus-operator" {
  info
  deploy() {
    apply katalog/prometheus-operator
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "prometheus-operator is Running" {
  info
  test() {
    kubectl get pods -l k8s-app=prometheus-operator -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy prometheus-operated" {
  info
  deploy() {
    apply katalog/prometheus-operated
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "prometheus-operated is Running" {
  info
  test() {
    kubectl get pods -l app.kubernetes.io/name=prometheus -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy alertmanager-operated" {
  info
  deploy() {
    apply katalog/alertmanager-operated
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "alertmanager-operated is Running" {
  info
  test() {
    kubectl get pods -l alertmanager=main -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy grafana" {
  info
  deploy() {
    apply katalog/grafana
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "grafana is Running" {
  info
  test() {
    kubectl get pods -l app=grafana -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy kube-state-metrics" {
  info
  deploy() {
    apply katalog/kube-state-metrics
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "kube-state-metrics is Running" {
  info
  test() {
    kubectl get pods -l app=kube-state-metrics -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy kubeadm-sm" {
  info
  deploy() {
    apply katalog/kubeadm-sm
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "Deploy node-exporter" {
  info
  deploy() {
    apply katalog/node-exporter
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "node-exporter is Running" {
  info
  test() {
    kubectl get pods -l app=node-exporter -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}

@test "Deploy kube-proxy-metrics" {
  info
  deploy() {
    apply katalog/kube-proxy-metrics
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "kube-proxy-metrics is Running" {
  info
  test() {
    kubectl get pods -l k8s-app=kube-proxy-metrics -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result:?}
  [ "$status" -eq 0 ]
}
