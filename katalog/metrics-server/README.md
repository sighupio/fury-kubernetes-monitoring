# Metrics Server

<!-- <KFD-DOCS> -->

Metrics Server is a cluster-wide aggregator of resource usage metrics for pods
and nodes.  These are the same metrics that you can access by using `kubectl
top`. The metrics server collects metrics from the Summary API, exposed by Kubelet
on each node.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `3.3.x`
- [cert-manager][cert] >= `1.0.0`

## Image repository and tag

* Metrics Server image: `registry.sighup.io/fury/metrics-server:v0.5.0`
* Metrics Server repo: [Metrics Server GH][ms-gh]
* Metrics Server documentation: [Metrics Server GH][ms-doc]

## Configuration

Fury distribution Metrics Server is deployed with the following configuration:

- Replica number: `1`
- Metrics are scraped from Kubelets every `30s`
- Skips verifying Kubelet CA certificates

## Deployment

You can deploy Metrics Server by running the following command in the root of the
project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[cert]: https://github.com/sighupio/fury-kubernetes-ingress/tree/master/katalog/cert-manager
[ms-gh]: https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/metrics-server
[ms-doc]: https://kubernetes.io/docs/tasks/debug-application-cluster/core-metrics-pipeline/

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
