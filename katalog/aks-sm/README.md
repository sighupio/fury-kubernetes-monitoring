# AKS ServiceMonitor

This package provides monitoring for Kubernetes components `kubelet` and
`api-server` on AKS.

## Requirements

- Kubernetes >= `1.14.0`
- Kustomize >= `3`
- [prometheus-operator](../prometheus-operator)


## Configuration

Fury distribution AKS ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals

## License

For license details please see [LICENSE](https://sighup.io/fury/license)

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource
for Prometheus.
