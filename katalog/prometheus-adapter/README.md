# Prometheus Adapter

<!-- <KFD-DOCS> -->

The Prometheus adapter provides an implementation of Kubernetes
[resource metrics](https://github.com/kubernetes/design-proposals-archive/blob/main/instrumentation/resource-metrics-api.md),
[custom metrics](https://github.com/kubernetes/design-proposals-archive/blob/main/instrumentation/custom-metrics-api.md), and
[external metrics](https://github.com/kubernetes/design-proposals-archive/blob/main/instrumentation/external-metrics-api.md) APIs.

This adapter is therefore suitable for use with the autoscaling/v2 Horizontal Pod Autoscaler in Kubernetes 1.6+.
It can also replace the [metrics server](https://github.com/kubernetes-incubator/metrics-server) on clusters that already run Prometheus and collect the appropriate metrics.

*Source:* [kubernetes-sigs/prometheus-adapter][pa-gh]

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize `= v3.5.3`
- [prometheus-operator](../prometheus-operator)
- [prometheus-operated](../prometheus-operated)

## Image repository and tag

- Prometheus adapter image: `registry.sighup.io/fury/prometheus-adapter/prometheus-adapter:v0.9.1`
- Prometheus adapter repository: [Prometheus adapter on GitHub][pa-gh]

## Configuration

Fury distribution Prometheus adapter is deployed with the following
configuration:
- Resource limits are `250m` for CPU and 180Mi for memory
- Listens on port 6443
- Metrics are scraped from Prometheus every `1m`

## Deployment
You can deploy prometheus-adapter by running the following command:

```shell
kustomize build katalog/prometheus-adapter | kubectl apply -f -
```

<!-- Links -->

[pa-gh]: https://github.com/kubernetes-sigs/prometheus-adapter

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
