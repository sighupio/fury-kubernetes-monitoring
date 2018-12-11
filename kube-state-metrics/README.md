# Kube State Metrics Katalog

This package provides kube-state-metrics service which listens to the Kubernetes API server and generates metrics about the state of Kubernetes objects like Deployments, Nodes or Pods.

From kube-state-metrics [repository]():

"That kube-state-metrics is about generating metrics from Kubernetes API objects without modification. This ensures, that features provided by kube-state-metrics have the same grade of stability as the Kubernetes API objects themselves. In turn this means, that kube-state-metrics in certain situation may not show the exact same values as kubectl, as kubectl applies certain heuristics to display comprehensible messages. kube-state-metrics exposes raw data unmodified from the Kubernetes API, this way users have all the data they require and perform heuristics as they see fit." 

## Requirements

- Kubernetes >= 1.10.0
- Kustomize => v1
- [prometheus-operator]()
- [prometheus-operated]()


## Image repository and tag
kube-state-metrics image : `quay.io/coreos/kube-state-metrics:v1.3.1`  

kube-state-metrics repo: [https://github.com/kubernetes/kube-state-metrics]()


## Configuration

Fury distribution kube-state-metrics is deployed with following configuration:
- Resource limits are `100m` for CPU and `150Mi` for memory 
- Listens on port 8081
- Exposes kubernetes-related metrics on port `8081` and metrics about itself on port `8082` and 
- Metrics are scraped every 30 seconds by Prometheus

## Deployment

You can deploy kube-state-metrics by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`

To learn how to customize it for your needs please see the [#Examples]() section.



## Alerts


## Examples

### How do you add a new rule
[FILL_ME]

### How do you add a new alert
[FILL_ME]


## License

For license details please see [LICENSE](license_link) 
