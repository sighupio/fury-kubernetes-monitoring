# kube-proxy exporter

<!-- <KFD-DOCS> -->

It is highly recommended gathering metrics from kube-proxy as it is a critical
piece of any Kubernetes Cluster. Sometimes (especially in managed clusters) it
is not possible to configure kube-proxy to expose metrics, this is why this
package exists. Another reason to run this exporter instead of just exposing
metrics from kube-proxy is the ability to run it independently of the
environment, on-premise installed by kubeadm or a managed Kubernetes Cluster.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize = `v3.3.X`
- [prometheus-operator](../prometheus-operator)


## Image repository and tag

- kube-rbac-proxy image: `registry.sighup.io/fury/brancz/kube-rbac-proxy:v0.11.0`
- kube-rbac-proxy repository: [kube-rbac-proxy on Github][krp-gh]


## Configuration

Fury distribution kube-proxy-metrics is deployed with the following configuration:

- Resource limits are `20m` for CPU and `40Mi` for memory
- Listens on port `18443`
- Metrics are scraped by Prometheus with `15s` intervals
- Requires `hostNetwork: true` and `hostPID: true`
- Runs as non-root user.


## Deployment

You can deploy kube-proxy-metrics by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[krp-gh]: https://quay.io/repository/brancz/kube-rbac-proxy

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
