# Metrics Server

Metrics Server is a cluster-wide aggregator of resource usage metrics for pods
and nodes.  These are the same metrics that you can access by using `kubectl
top`. Metrics server collects metrics from the Summary API, exposed by Kubelet
on each node.


## Requirements

- Kubernetes >= `1.8.0`
- Kustomize >= `3`
- cert-manager < `0.11.0`


## Image repository and tag

* Metrics Server image: `gcr.io/google_containers/metrics-server-amd64:v0.3.6`
* Metrics Server repo: https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/metrics-server
* Metrics Server documentation: https://kubernetes.io/docs/tasks/debug-application-cluster/core-metrics-pipeline/


## Configuration

Fury distribution Metrics Server is deployed with following configuration:

- Replica number: `1`
- Metrics are scraped from Kubelets every `30s`
- Skips verifying Kubelet CA certificates


## Deployment

You can deploy Metrics Server by running following command in the root of the
project:

```shell
$ kustomize build | kubectl apply -f -
```


## License

For license details please see [LICENSE](https://sighup.io/fury/license)
