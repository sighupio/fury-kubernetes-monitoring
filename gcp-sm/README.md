# GCP Sm Katalog

This package provides monitoring for kubelet components on Google Cloud Platform. Kubelet exposes its metrics on two different endpoints: 
- `/` : Http metrics
- `/metrics/cadvisor/` : Kubernetes built-in monitoring 

### Image repository and tag

There is no image used since this packages provides only ServiceMonitor resource for Prometheus. To learn about ServiceMonitor resources used by Prometheus Operator please follow [prometheus-operated]() documentation.


## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator]()
- [prometheus-operated]()


## Configuration

Fury distribution GCP Service Monitor has following configuration:

- Metrics are scraped with `30s` intervals 
- namespace : `kube-system`


## Examples

### How do you add a new rule
[FILL_ME]

### How do you add a new alert
[FILL_ME]





## License

For license details please see [LICENSE](license_link) 
