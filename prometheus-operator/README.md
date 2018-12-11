# Prometheus Operator Katalog

Operators are application specific controllers for complex stateful applications. They are used to have more Kubernetes-native control over applications. Prometheus Operator makes it easy to deploy and manage Prometheus instances. But also provides easy monitoring definitions for Kubernetes services. We can easily deploy Prometheus servers and use advanced options in the Prometheus CDR to let the Operator handle version upgrades, persistent volume claims and connecting Prometheus to Alert Manager instances. Thanks to Prometheus Operator you don't have to learn Prometheus specific configuration language to monitor your services. Service targeting is achieved via Kubernetes labels and monitoring target configurations are automatically generated based on Kubernetes label queries. To learn how to configure alerts with Prometheus AlertManager please visit [alertmanager-operated]() package documentation.

The Operator acts on the following custom resource definitions ([CRDs](link)):

- `Prometheus`: defines a desired Prometheus deployment. It's used by the Operator to deploy Prometheus instances.

- `ServiceMonitor`: declaratively specifies how groups of services should be monitored. The Operator automatically generates Prometheus scrape configuration based on the definition.

- `PrometheusRule`: defines a desired Prometheus rule file, which is going to be loaded by a Prometheus instance containing Prometheus alerting and recording rules.

- `Alertmanager`, defines a desired Alertmanager deployment. It's used by the Operator to deploy AlertManager instances.

Operator takes care of Prometheus deployment and monitors Services as illustrated in this image:

![operator architecture](https://coreos.com/sites/default/files/inline-images/p1.png)


## Requirements
- Kubernetes >= 1.10.0
- Kustomize v1


## Image repository and tag

* Prometheus Operator image: `quay.io/coreos/prometheus-operator:v0.25.0`

* Prometheus Operator repository: [https://github.com/coreos/prometheus-operator]()

* You can have further details about Prometheus Operator on this [blog post](https://coreos.com/blog/the-prometheus-operator.html)


## Configuration

Fury distribution Prometheus Opeator is deployed with following configuration:
- Replica number : `1` 
- Requires `50Gi` storage(with default storage type of Provider)
- Logging to stderr is enabled
- Resource limits are `200m` for CPU and `200Mi` for memory
- Listens on port `8080` 


## Deployment

You can deploy Prometheus Operator by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`

To learn how to customize it for your needs please see the [#Examples]() section.



## What is Prometheus

Prometheus is a monitoring tool to collect metric based time series data and provides a functional expression language that lets the user select and aggregate time series data in real time. 
The result of an expression can either be shown as a graph, viewed as tabular data in Prometheus's expression browser, or consumed by external systems via the HTTP API.

Once Prometheus Operator is deployed, you can deploy Prometheus and AlertManager instances via Operator. Then you will be able to monitor and send notifications about your services deployed on Kubernetes cluster. To learn how to deploy Prometheus instances via Prometheus Operator please see [prometheus-operated]() documentation.


### Service Monitoring

Configuration of Prometheus for service monitoring is realized via ServiceMonitor resource. It specifies how metrics can be retrieved from a set of services and Prometheus dynamically includes ServiceMonitor objects by their labels. To learn how to create ServiceMonitor resources for your services please see the documentation of [prometheus-operatod]()


### Alerts

The Alertmanager handles alerts sent by client applications such as the Prometheus server. It takes care of deduplicating, grouping, and routing them to the correct receiver integration such as email, PagerDuty, or OpsGenie. It also takes care of silencing and inhibition of alerts. The Prometheus Operator introduces an Alertmanager resource, which allows users to declaratively describe an Alertmanager cluster. To learn how to deploy Alert Manager please visit [alertmanager-operated]()


## Examples
?

## License

For license details please see [LICENSE](license_link) 
