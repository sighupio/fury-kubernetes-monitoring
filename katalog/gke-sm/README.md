# GKE ServiceMonitor

This package provides monitoring for Kubernetes component `kubelet` and
`api-server` on GKE.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize = `v1.0.10`
- [prometheus-operator](../prometheus-operator)

## Configuration

Fury distribution GKE ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals
- Automatically discover `kubelet` and `api-server` scraping targets enpoints

## License

For license details please see [LICENSE](https://sighup.io/fury/license)

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource
for Prometheus.