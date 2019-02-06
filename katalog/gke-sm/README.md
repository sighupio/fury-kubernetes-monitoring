# GCP ServiceMonitor 

This package provides monitoring for Kubernetes component `kubelet` on GKE. 

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource
for Prometheus.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize = `v1.0.10`
- [prometheus-operator](../prometheus-operator)


## Configuration

Fury distribution GCP ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals

## License

For license details please see [LICENSE](https://sighup.io/fury/license)