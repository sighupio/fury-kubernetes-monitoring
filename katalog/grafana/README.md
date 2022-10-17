# Grafana

Grafana is an open-source data visualization and graph composer platform for
numeric time-series data with Prometheus integration.

## Image repository and tag

- Grafana image: `grafana/grafana:8.1.2`
- Grafana repository: [https://github.com/grafana/grafana](https://github.com/grafana/grafana)
- Grafana documentation: [https://docs.grafana.org](https://docs.grafana.org)
- k8s-sidecar image: `kiwigrid/k8s-sidecar`
- k8s-sidecar repository: <https://github.com/kiwigrid/k8s-sidecar>
- k8s-sidecar documentation: <https://github.com/kiwigrid/k8s-sidecar/blob/master/README.md>

## Requirements

- Kubernetes >= `1.18.0`
- Kustomize = `v3.5.3`

## Configuration

Fury distribution Grafana is deployed with the following configuration:

- Replica number: `1`
- Anonymous authentication enabled
- `Admin` role for unauthenticated users
- Resource limits are `200m` for CPU and `200Mi` for memory
- Listens on port `3000`
- Prometheus configured as the data source

## Add new dashboards

You can create a Configmap in your project with a JSON of a grafana dashboard and then labeling it with the label
key = "grafana-sighup-dashboard", the value of the label is up to you (for mental healthiness should be better than
the value respects some sort of reference with the project to with the dashboard is related). Labeling it, the sidecar
k8s-sidecar will take care of it and inject it into a shared volume where grafana does a lookup and discover it.
Look at the [dashboards](dashboards) folder kustomization.yml for an example.

## Deployment

You can deploy Grafana by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

### Accessing Grafana UI

You can access Grafana Dashboard by port-forwarding on port `3000`:

```shell
kubectl port-forward svc/grafana 3000:3000 --namespace monitoring
```

Grafana will be available on [http://127.0.0.1:3000](http://127.0.0.1:3000) from your browser.

### Adding/Removing Dashboards

To learn how to add or remove dashboards to Grafana please see the
[examples](../../examples) folder.

## License

For license details please see [LICENSE](../../LICENSE)
