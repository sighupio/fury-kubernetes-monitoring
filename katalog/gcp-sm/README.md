# GCP ServiceMonitor Katalog

This package provides monitoring for kubelet components on GKE. Kubelet exposes
its metrics on two different endpoints:
- `/metrics`: kubelet metrics
- `/metrics/cadvisor/`: container metrics

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource
for Prometheus.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`
- [prometheus-operator](../prometheus-operator)


## Configuration

Fury distribution GCP ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals
- Matched namespace: `kube-system`


## License

For license details please see [LICENSE](https://sighup.io/fury/license)
