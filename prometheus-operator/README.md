# Prometheus Operator Katalog

Operators are application specific controllers for complex stateful applications. They are used to have more Kubernetes-native control over applications. Prometheus Operator makes it easy to deploy and manage Prometheus instances. But also provides easy monitoring definitions for Kubernetes services. We can easily deploy Prometheus servers and use advanced options in the Prometheus CDR to let the Operator handle version upgrades, persistent volume claims and connecting Prometheus to Alert Manager instances. Thanks to Prometheus Operator you don't have to learn Prometheus specific configuration language to monitor your services. Service targeting is achieved via Kubernetes labels and monitoring target configurations are automatically generated based on Kubernetes label queries. To learn how to configure alerts with Prometheus AlertManager please visit [alertmanager-operated]() package documentation.

The Operator acts on the following custom resource definitions ([CRDs](link)):

- `Prometheus`: defines a desired Prometheus deployment. It's used by the Operator to deploy Prometheus instances.

- `ServiceMonitor`: declaratively specifies how groups of services should be monitored. The Operator automatically generates Prometheus scrape configuration based on the definition.

- `PrometheusRule`: defines a desired Prometheus rule file, which is going to be loaded by a Prometheus instance containing Prometheus alerting and recording rules.

- `Alertmanager`, defines a desired Alertmanager deployment. It's used by the Operator to deploy AlertManager instances.

Operator takes care of Prometheus deployment and monitors Services as illustrated in this image:

![operator architecture](https://coreos.com/sites/default/files/inline-images/p1.png)

## What is Prometheus

Prometheus is a monitoring tool to collect metric based time series data and provides a functional expression language that lets the user select and aggregate time series data in real time. 
The result of an expression can either be shown as a graph, viewed as tabular data in Prometheus's expression browser, or consumed by external systems via the HTTP API.


### Image repository and tag

* Prometheus Operator image: `quay.io/coreos/prometheus-operator:v0.25.0`

* Prometheus Operator repository: [https://github.com/coreos/prometheus-operator]()

* You can have further details about Prometheus Operator on this [blog post](https://coreos.com/blog/the-prometheus-operator.html)

### Configuration

//Explain operator flags and/or what they can customize at deployment.


### Deployment

You can deploy Prometheus Operator by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`

Once Prometheus Operator is deployed, you can deploy Prometheus and AlertManager instances via Operator. To learn how to deploy them please visit their package documentation under Fury Kubernetes Monitoring repo. Then you will be able to monitor and and send notifications about your services deployed on Kubernetes cluster.


### Accessing Prometheus UI

//Explain port forwarding with service


## Service Monitoring

Our Prometheus Operator package deploys Prometheus to monitor both cluster itself and applications deployed on cluster. The Operator configures the Prometheus instance to monitor all services covered by included ServiceMonitors and keeps this configuration synchronized with any changes happening in the cluster.

Targeting services to monitor is very easy with Prometheus Operator. ServiceMonitor CRD let us to create a monitoring configuration to apply services with matching label. Let say you have services with label `app: frontend` which exposes metrics on port `metric` under standard path `/metrics`. With ServiceMonitor you express that you want to monitor metrics exposed by these services.

```yaml
apiVersion: monitoring.coreos.com/v1alpha1
kind: ServiceMonitor
metadata:
  name: frontend
  labels:
    app: frontend
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: frontend
  endpoints:
  - port: metric 
      interval: 10s 
```

ServiceMonitors belonging to a Prometheus setup are selected, once again, based on labels. When deploying said Prometheus instance, the Operator configures it according to the matching service monitors.
  Define that all ServiceMonitor TPRs with the label `tier = frontend` should be included into the server's configuration.

```yaml
apiVersion: monitoring.coreos.com/v1alpha1
kind: Prometheus
metadata:
  name: prometheus-frontend
    labels:
        prometheus: frontend
spec:
  version: v1.3.0
    serviceMonitors:
    - selector:
        matchLabels:
          app: frontend
```


Prometheus will automatically pick up new services having the tier = frontend label and adapt to their deployments scaling up and down. Additionally, the Operator will immediately reconfigure Prometheus appropriately if ServiceMonitors are added, removed, or modified.

## Alerts

The Alertmanager handles alerts sent by client applications such as the Prometheus server. It takes care of deduplicating, grouping, and routing them to the correct receiver integration such as email, PagerDuty, or OpsGenie. It also takes care of silencing and inhibition of alerts. The Prometheus Operator introduces an Alertmanager resource, which allows users to declaratively describe an Alertmanager cluster. To learn how to deploy Alert Manager please visit [alertmanager-operated]()


## Examples
// Some examples here


## License

For license details please see [LICENSE](license_link) 
