# AKS ServiceMonitor

This package provides monitoring for Kubernetes components `kubelet` and
`api-server` on AKS.

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource
for Prometheus.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize = `v1.0.10`
- [prometheus-operator](../prometheus-operator)


## Configuration

Fury distribution AKS ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals
- Relabel metrics in order for the discovered targets to point to the correct
  endpoints


## License

For license details please see [LICENSE](https://sighup.io/fury/license)
