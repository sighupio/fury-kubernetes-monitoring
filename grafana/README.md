# Grafana Katalog

Grafana is an open source data visualization and graph composer platform for numeric time-series data. It has built in support for Prometheus. you can use it to visualize metrics scraped by Prometheus. It offers different types of visualization options, form pie charts to histograms and to heatmaps. You can choose different graphs to analyze better your metrics. To create your graphs you need to use Prometheus query language PromQL. With Grafana you can also template queries for generic dashboards. 


## Image repository and tag

Grafana image: `grafana/grafana:5.3.4`

Grafana documentation: [https://grafana.com/grafana]() 

## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator]()
- [prometheus-operated]()


## Configuration

Fury distribution Grafana is deployed with following configuration:
- Replica number : `1` 
- Anonymous authentication enabled
- Role for unauthenticated users as `Admin`
- Resource limits are `200m` for CPU and `200Mi` for memory
- Listens on port `3000`
- Data source is Prometheus
- Dashboards ready to use for following entities(see `grafana/dashboards/`):
   * coreDNS
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

`$ kustomize build | kubectl apply -f -`

To learn how to customize it for your needs please see the [#Examples]() section.


### How do you access Grafana 

You can access Grafana Dashboard by port-forwarding on port `3000`:

`kubectl port-forward svc/grafana 3000:3000`

Grafana will be available on `http://127.0.0.1:3000` from your browser.


## Examples


### How do you add a new graph
[FILL_ME]


## License

For license details please see [LICENSE](license_link) 
