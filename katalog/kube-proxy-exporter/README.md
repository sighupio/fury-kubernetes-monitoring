# kube-proxy exporter

It is highly recommended to gather metrics from kube-proxy as it is a critical piece of any Kubernetes Cluster.
Sometimes (especially in managed clusters) it is not possible to configure kube-proxy to expose metrics, this is why
this package exists. Another reason to run this exporter instead of just exposing metrics from kube-proxy is the


## Requirements

- Kubernetes >= `1.16.0`
- Kustomize = `v3.0.X`
- [prometheus-operator](../prometheus-operator)


## Image repository and tag

- kube-rbac-proxy image: `quay.io/brancz/kube-rbac-proxy:v0.6.0`
- kube-rbac-proxy repository:
  <https://github.com/brancz/kube-rbac-proxy>


## Configuration

Fury distribution kube-proxy-exporter is deployed with the following configuration:

- Resource limits are `20m` for CPU and `40Mi` for memory
- Listens on port `18443`
- Metrics are scraped by Prometheus with `15s` intervals
- Requires `hostNetwork: true` and `hostPID: true`
- Runs as non-root user.


## Deployment

You can deploy kube-proxy-exporter by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```


## License

For license details please see [LICENSE](../../LICENSE)