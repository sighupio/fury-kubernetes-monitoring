# GKE ServiceMonitor

This package provides monitoring for Kubernetes components `kubelet` and
`api-server` on GKE.

## Requirements

- Kubernetes >= `1.21.0`
- Kustomize = `3.5.3`
- [prometheus-operator](../../prometheus-operator)

## Configuration

Fury distribution GKE ServiceMonitor has following configuration:

- `api-server` and `kubelet` metrics are scraped with `30s` intervals
- Dashboards shipped:
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
