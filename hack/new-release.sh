#!/usr/bin/env bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


set -e
set -u
set -o pipefail

UPSTREAM_REPO="https://github.com/prometheus-operator/kube-prometheus"

if [ $# -ne 2 ]; then
  echo "Usage: $(basename $0) <upstream_release> <fury_package>" 1>&2
  echo "Where:" 1>&2
  echo "  - <upstream_release> must be a valid reference in the ${UPSTREAM_REPO} Git repository" 1>&2
  echo "  - <fury_package> must be one of:" 1>&2
  echo "    - aks-sm" 1>&2
  echo "    - alertmanager-operated" 1>&2
  echo "    - blackbox-exporter" 1>&2
  echo "    - eks-sm" 1>&2
  echo "    - gke-sm" 1>&2
  echo "    - grafana" 1>&2
  echo "    - kube-state-metrics" 1>&2
  echo "    - kubeadm-sm" 1>&2
  echo "    - node-exporter" 1>&2
  echo "    - prometheus-adapter" 1>&2
  echo "    - prometheus-operated" 1>&2
  echo "    - prometheus-operator" 1>&2
  exit 1
fi

UPSTREAM_RELEASE="${1}"
FURY_MODULE="${2}"

WORK_DIR="$(mktemp -d kube.prometheus.XXXXXX -p /tmp)"
KATALOG_PATH="$(dirname $(readlink -e "${0}"))/../katalog"

function cleanup {
  echo "Deleting temporary working directory ${WORK_DIR}"
  rm -rf "${WORK_DIR}"
}

function populate_package {
  local prefix="${1}"

  ls -1 "${WORK_DIR}"/manifests/"${prefix}"-*.yaml | \
    tr "-" " " | \
    while read package resource; do
      # echo "package: ${package}"
      # echo "resource: ${resource}"
      cp -af "${package}"-"${resource}" "${KATALOG_PATH}/${FURY_MODULE}/${resource}"
    done
}


trap cleanup EXIT

git clone "${UPSTREAM_REPO}" "${WORK_DIR}"

git -C "${WORK_DIR}" checkout "${UPSTREAM_RELEASE}"

rm -rf "${WORK_DIR}"/manifests/*-podDisruptionBudget.yaml \
  "${WORK_DIR}"/manifests/*-networkPolicy.yaml

case "${FURY_MODULE}" in
  "aks-sm")
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorApiserver.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/apiserver.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorCoreDNS.yaml" "${KATALOG_PATH}/configs/bases/coredns/service-monitors/coredns.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/controller-manager.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeScheduler.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/scheduler.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubelet.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/kubelet.yml"
    ;;
  "eks-sm")
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorApiserver.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/apiserver.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorCoreDNS.yaml" "${KATALOG_PATH}/configs/bases/coredns/service-monitors/coredns.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/controller-manager.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeScheduler.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/scheduler.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubelet.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/kubelet.yml"
    ;;
  "gke-sm")
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorApiserver.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/apiserver.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorCoreDNS.yaml" "${KATALOG_PATH}/configs/bases/coredns/service-monitors/coredns.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/controller-manager.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeScheduler.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/scheduler.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubelet.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/kubelet.yml"
    ;;
  "kubeadm-sm")
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorApiserver.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/apiserver.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorCoreDNS.yaml" "${KATALOG_PATH}/configs/bases/coredns/service-monitors/coredns.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/controller-manager.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubeScheduler.yaml" "${KATALOG_PATH}/configs/kubeadm/service-monitors/scheduler.yml"
    mv "${WORK_DIR}/manifests/kubernetesControlPlane-serviceMonitorKubelet.yaml" "${KATALOG_PATH}/configs/bases/default/service-monitors/kubelet.yml"
    ;;
  "alertmanager-operated")
    populate_package "alertmanager"

    rm -f "${KATALOG_PATH}/${FURY_MODULE}/secret.yaml"
    ;;
  "blackbox-exporter")
    populate_package "blackboxExporter"
    ;;
  "grafana")
    populate_package "grafana"

    # Extract all the dashboards to single ConfigMap YAML files
    yq '.items[].metadata.name' < "${KATALOG_PATH}/${FURY_MODULE}/dashboardDefinitions.yaml" | \
    while read d; do
      yq ".items[] | select (.metadata.name == \"${d}\")" < "${KATALOG_PATH}/${FURY_MODULE}/dashboardDefinitions.yaml" > "${KATALOG_PATH}/${FURY_MODULE}/dashboards/${d}.yaml"
    done

    # Extract JSON dashboard from ConfigMap YAML files
    find "${KATALOG_PATH}/${FURY_MODULE}/dashboards" -type f -name '*.yaml' | \
    grep -v kustomization.yaml | \
    while read d; do
      while read f; do
        yq ".data[\"${f}\"]" < "${d}" > "${KATALOG_PATH}/${FURY_MODULE}/dashboards/${f}"
        rm -f "${d}"
      done < <(yq '.data | keys | @tsv' < "${d}")
    done

    # Move dashboards in the right packages
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/alertmanager-overview.json" "${KATALOG_PATH}/alertmanager-operated/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/apiserver.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/cluster-total.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/controller-manager.json" "${KATALOG_PATH}/configs/kubeadm/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-cluster.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-namespace.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-node.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-pod.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-workload.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/k8s-resources-workloads-namespace.json" "${KATALOG_PATH}/kube-state-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/kubelet.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/namespace-by-pod.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/namespace-by-workload.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/node-cluster-rsrc-use.json" "${KATALOG_PATH}/node-exporter/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/node-rsrc-use.json" "${KATALOG_PATH}/node-exporter/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/nodes.json" "${KATALOG_PATH}/node-exporter/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/persistentvolumesusage.json" "${KATALOG_PATH}/configs/bases/default/dashboards/persistent-volumes-usage.json"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/pod-total.json" "${KATALOG_PATH}/configs/bases/default/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/prometheus-remote-write.json" "${KATALOG_PATH}/prometheus-operated/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/prometheus.json" "${KATALOG_PATH}/prometheus-operated/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/proxy.json" "${KATALOG_PATH}/kube-proxy-metrics/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/scheduler.json" "${KATALOG_PATH}/configs/kubeadm/dashboards"
    mv "${KATALOG_PATH}/${FURY_MODULE}/dashboards/workload-total.json" "${KATALOG_PATH}/configs/bases/default/dashboards"

    rm -f "${KATALOG_PATH}/${FURY_MODULE}/dashboardDefinitions.yaml" \
      "${KATALOG_PATH}/${FURY_MODULE}/dashboardDatasources.yaml" \
    ;;
  "kube-state-metrics")
    populate_package "kubeStateMetrics"
    ;;
  "node-exporter")
    populate_package "nodeExporter"
    ;;
  "prometheus-adapter")
    populate_package "prometheusAdapter"
    ;;
  "prometheus-operated")
    populate_package "prometheus"

    mv "${WORK_DIR}/manifests/kubePrometheus-prometheusRule.yaml" "${KATALOG_PATH}/${FURY_MODULE}/kube-prometheus-rules.yml"
    sed -i "s/Watchdog/DeadMansSwitch/" "${KATALOG_PATH}/${FURY_MODULE}/kube-prometheus-rules.yml"

    mv "${WORK_DIR}/manifests/kubernetesControlPlane-prometheusRule.yaml" "${KATALOG_PATH}/${FURY_MODULE}/kubernetes-monitoring-rules.yml"

    echo -e "\033[0;31m⚠: you have to remove from $(readlink -e ${KATALOG_PATH}/${FURY_MODULE}/kubernetes-monitoring-rules.yml) CPUThrottlingHigh and move KubeClientCertificateExpiration, KubeSchedulerDown and KubeControllerManagerDown to $(readlink -e ${KATALOG_PATH}/configs/kubeadm/rules.yml)\033[0m"

    rm -f roleBindingSpecificNamespaces.yaml roleSpecificNamespaces.yaml
    ;;
  "prometheus-operator")
    populate_package "prometheusOperator"

    cp -af "${WORK_DIR}"/manifests/setup/0* ~/src/github.com/sighupio/fury-kubernetes-monitoring/katalog/prometheus-operator/crds
    ;;
  *)
    echo "$(basename $0): error: unknown package ${FURY_MODULE}" 1>&2
    exit 1
    ;;
esac

exit 0
