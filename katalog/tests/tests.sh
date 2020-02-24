#!/usr/bin/env bats

load ./helper

@test "Applying prometheus-operator, cert-manager CRDs and cert-manager" {
  info
  kubectl apply -f katalog/prometheus-operator/crd-servicemonitor.yml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-ingress/master/katalog/cert-manager/cert-manager-controller/crd.yml
  apply "github.com/sighupio/fury-kubernetes-ingress.git//katalog/cert-manager/?ref=v1.4.1"
}

@test "Deploy prometheus-operator" {
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
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy prometheus-operated" {
  deploy() {
    apply katalog/prometheus-operated
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "prometheus-operated is Running" {
  info
  test() {
    kubectl get pods -l app=prometheus -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy alertmanager-operated" {
  deploy() {
    apply katalog/alertmanager-operated
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "alertmanager-operated is Running" {
  info
  test() {
    kubectl get pods -l app=alertmanager -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy goldpinger" {
  deploy() {
    apply katalog/goldpinger
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "goldpinger is Running" {
  info
  test() {
    kubectl get pods -l k8s-app=goldpinger -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy grafana" {
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
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy kube-state-metrics" {
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
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy kubeadm-sm" {
  deploy() {
    apply katalog/kubeadm-sm
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "Deploy metrics-server" {
  deploy() {
    apply katalog/metrics-server
  }
  run deploy
  [ "$status" -eq 0 ]
}

@test "metrics-server is Running" {
  info
  test() {
    kubectl get pods -l app=metrics-server -o json -n kube-system | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 60 10
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}

@test "Deploy node-exporter" {
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
  status=${loop_it_result}
  [ "$status" -eq 0 ]
}