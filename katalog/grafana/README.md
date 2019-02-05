# Grafana 

Grafana is an open source data visualization and graph composer platform for
numeric time-series datai with Prometheus integration.


## Image repository and tag

* Grafana image: `grafana/grafana:5.3.4`
* Grafana repo: https://github.com/grafana/grafana
* Grafana documentation: https://docs.grafana.org


## Requirements

- Kubernetes >= `1.10.0`
- Kustomize = `v1.0.10`



## Configuration

Fury distribution Grafana is deployed with following configuration:
- Replica number: `1`
- Anonymous authentication enabled
- Role for unauthenticated users as `Admin`
- Resource limits are `200m` for CPU and `200Mi` for memory
- Listens on port `3000`
- Data source is Prometheus
- Dashboards ready to use (see [dashboards](dashboards) folder):
   * CoreDNS
   * Etcd
   * Gluster Nodes
   * Gluster Utilisation
   * Kubernetes Cluster
   * Kubernetes Deployments
   * Kubernetes Nodes
   * Kubernetes Pods
   * Kubernetes Statefulsets
   * Nginx Ingress Controller


## Deployment

You can deploy Grafana by running following command in the root of the project:

```shell
$ kustomize build | kubectl apply -f -
```


### Accessing Grafana UI

You can access Grafana Dashboard by port-forwarding on port `3000`:

```shell
$ kubectl port-forward svc/grafana 3000:3000 --namespace monitoring
```

Grafana will be available on http://127.0.0.1:3000 from your browser.


### Adding/Removing Dashboards

To learn how to add or remove dashboards to Grafana please see the
[examples](../../examples) folder.


## License

For license details please see [LICENSE](https://sighup.io/fury/license)
