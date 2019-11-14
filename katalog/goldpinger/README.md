# Goldpinger

**Goldpinger** makes calls between its instances for visibility and alerting. It runs as a `DaemonSet` on `Kubernetes` 
and produces `Prometheus` metrics that can be scraped, visualised and alerted on.

*Source: *[bloomberg/goldpinger](https://github.com/bloomberg/goldpinger/tree/2.0.0).

### Image repository and tag

- goldpinger image: `docker.io/bloomberg/goldpinger:2.0.0`.
- goldpinger repository: [https://github.com/bloomberg/goldpinger](https://github.com/bloomberg/goldpinger).

## Requirements

- Tested with Kubernetes >= `1.14.X`.
- Tested with Kustomize = `v3.0.X`.
- [Service monitor](sm.yml) also requires [prometheus-operator](../prometheus-operator).

## Configuration

Fury distribution goldpinger is deployed with following configuration:
- Resource limits is `80Mi` for memory.
- Listens on port `8080`.
- Exposes prometheus metrics on port `8080`.
- Exposes it's own dashboard as a NodePort `31080`.
- Metrics are scraped by Prometheus with `30s` intervals.

## Deployment

You can deploy goldpinger by running following command in the root of this project:

```shell
$ kustomize build | kubectl apply -f -
```

## License

For license details please see [LICENSE](./../../LICENSE)
