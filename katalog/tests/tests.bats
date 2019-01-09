#!/usr/bin/env bats

apply (){
  kustomize build $1 | kubectl apply -f -
}

@test "testing prometheus-operator apply" {
  test(){
    apply katalog/prometheus-operator || apply katalog/prometheus-operator
  }
  run test
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

@test "wait for apply to settle and dump state to dump.json" {
  max_retry=0
  while echo "=====" $max_retry "=====" && kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\)" ; do
    [ $max_retry -lt 12 ] || ( kubectl describe pods --all-namespaces && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$[ $max_retry + 1 ]
  done
  kubectl get all --all-namespaces -o json > /dump.json
}

@test "check prometheus-operator" {
  test(){
    jq '.items[] | select( .kind == "Deployment" and .metadata.name == "prometheus-operator" ) | .status.replicas == .status.readyReplicas ' < /dump.json | grep -iv true
  }
  run test
  [ "$output" == "" ]
}

@test "check alertmanager-operated" {
  test(){
    jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "alertmanager-main" ) | .status.replicas == .status.readyReplicas ' < /dump.json | grep -iv true
  }
  run test
  [ "$output" == "" ]
}


@test "check node-exporter" {
  test(){
    jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "alertmanager-main" ) | .status.desiredNumberScheduled == .status.currentNumberScheduled ' < /dump.json | grep -iv true
  }
  run test
  [ "$output" == "" ]
}

@test "check grafana" {
  test(){
    jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "grafana" ) | .status.replicas == .status.readyReplicas ' < /dump.json | grep -iv true
  }
  run test
  [ "$output" == "" ]
}

@test "check prometheus-operated" {
  test(){
    jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "prometheus-k8s" ) | .status.replicas == .status.readyReplicas ' < /dump.json | grep -iv true
  }
  run test
  [ "$output" == "" ]
}
