#!/usr/bin/env bats

apply (){
  kustomize build $1 >&2
  kustomize build $1 | kubectl apply -f - 2>&3
}

@test "testing prometheus-operator apply" {
  test(){
    apply katalog/prometheus-operator || apply katalog/prometheus-operator
    sleep 20
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
  patch(){
    kubectl patch alertmanager main -n monitoring -p='[{"op": "add", "path": "/spec/replicas", "value": 2}]' --type json
  }
  run apply katalog/alertmanager-operated
  apply_result="$status"
  run patch
  patch_result="$status"
  [ "$apply_result" -eq 0 ] && [ "$patch_result" -eq 0 ]
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
  echo "Waiting 30 seconds to prometheus-operator to spin up alertmanager-operated and prometheus-operated" >&2
  sleep 30
  max_retry=0
  echo "=====" $max_retry "=====" >&2
  while kubectl get pods --all-namespaces | grep -ie "\(Pending\|Error\|CrashLoop\|ContainerCreating\)" >&2
  do
    [ $max_retry -lt 24 ] || ( kubectl describe all --all-namespaces >&2 && return 1 )
    sleep 10 && echo "# waiting..." $max_retry >&3
    max_retry=$[ $max_retry + 1 ]
  done
}

@test "check prometheus-operator exists" {
  test(){
    kubectl get deployment --all-namespaces -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "prometheus-operator")'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" != "" ]
}

@test "check prometheus-operator status" {
  test(){
    kubectl get deployment --all-namespaces -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "prometheus-operator" and .status.replicas != .status.availableReplicas )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check alertmanager-operated exists" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "alertmanager-main")'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" != "" ]
}

@test "check alertmanager-operated status" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "alertmanager-main" and .status.replicas != .status.readyReplicas )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}


@test "check node-exporter exists" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "DaemonSet" and .metadata.name == "node-exporter" )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" != "" ]
}

@test "check node-exporter status" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "DaemonSet" and .metadata.name == "node-exporter" and .status.desiredNumberScheduled != .status.numberReady )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check grafana exists" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "grafana")'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" != "" ]
}

@test "check grafana status" {
  test(){
    kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "Deployment" and .metadata.name == "grafana" and .status.replicas != .status.availableReplicas )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "check prometheus-operated exists" {
  test(){
      kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "prometheus-k8s")'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" != "" ]
}

@test "check prometheus-operated status" {
  test(){
      kubectl get all --all-namespaces -o json | jq '.items[] | select( .kind == "StatefulSet" and .metadata.name == "prometheus-k8s" and .status.replicas != .status.readyReplicas )'
  }
  run test
  echo "$output" | jq '.' >&2
  [ "$output" == "" ]
}

@test "cleanup" {
  if [ -z "${LOCAL_DEV_ENV}" ];
  then
    skip
  fi
  sleep 30
  for dir in kube-state-metrics node-exporter alertmanager-operated grafana kubeadm-sm prometheus-operated prometheus-operator
  do
    echo "# deleting katalog/$dir" >&3
    kustomize build katalog/$dir | kubectl delete -f - || true
    echo "# deleted katalog/$dir" >&3
  done
}
