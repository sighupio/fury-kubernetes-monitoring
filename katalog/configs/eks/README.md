# EKS ServiceMonitor

This package provides monitoring for Kubernetes components `kubelet` and
`api-server` on EKS.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `3.3.0`
- [prometheus-operator](../../prometheus-operator)

## Configuration

Fury distribution EKS ServiceMonitor has following configuration:

- `api-server` and `kubelet` metrics are scraped with `30s` intervals
- `coredns` metrics are scraped with `15s` intervals
- Dashboards shipped:
  - `coredns`: CoreDNS < 1.7.0
  - `api-server`: Kubernetes / API server
  - `cluster-total`: Kubernetes / Networking / Cluster
  - `kubelet`: Kubernetes / Kubelet
  - `namespace-by-pod`: Kubernetes / Networking / Namespace (Pods)
  - `namespace-by-workload`: Kubernetes / Networking / Namespace (Workload)
  - `persistent-volumes-usage`: Kubernetes / Persistent Volumes
  - `pod-total`: Kubernetes / Networking / Pod
  - `workload-total`: Kubernetes / Networking / Workload

## License

For license details please see [LICENSE](../../../LICENSE)
