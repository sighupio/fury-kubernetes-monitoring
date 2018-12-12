# GCP Sm Katalog

This package provides monitoring for kubelet components on GKE. Kubelet exposes its metrics on two different endpoints: 
- `/` : Http metrics
- `/metrics/cadvisor/` : Kubernetes built-in monitoring 

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource for Prometheus. 

## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1


## Configuration

Fury distribution GCP ServiceMonitor has following configuration:

- Metrics are scraped with `30s` intervals 
- namespace : `kube-system`


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
