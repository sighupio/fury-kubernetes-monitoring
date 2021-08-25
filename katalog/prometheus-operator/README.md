# Prometheus Operator

Operators are application-specific controllers for complex stateful
applications. They are used to having more Kubernetes-native control over
applications. Prometheus Operator makes it easy to deploy and manage Prometheus
instances. But also provides easy monitoring definitions for Kubernetes
services. We can easily deploy Prometheus servers and use advanced options in
the Prometheus CRD to let the Operator handle version upgrades, persistent
volume claims, and the discovery of Alertmanager instances. Thanks to Prometheus
Operator you don't have to learn Prometheus-specific configuration language to
monitor your services. Target discovery is achieved through ServiceMonitor CRD,
target configurations are automatically generated based on Kubernetes label
selectors.

The Operator acts on the following custom resource definitions
([CRDs](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)):

- `Prometheus`: defines the desired Prometheus deployment. It's used by the
  Operator to deploy Prometheus instances.

- `ServiceMonitor`: declaratively specifies how groups of services should be
  monitored. The Operator automatically generates Prometheus scrape
  configuration based on the definition.

- `PrometheusRule`: defines a desired Prometheus rule file, which is going to be
  loaded by a Prometheus instance containing Prometheus alerting and recording
  rules.

- `Alertmanager`, defines a desired Alertmanager deployment. It's used by the
  Operator to deploy AlertManager instances.

The operator takes care of Prometheus deployment and monitors Services as
illustrated in this image from Prometheus Operator repository:

![operator
architecture](https://coreos.com/sites/default/files/inline-images/p1.png)


## Requirements

- Kubernetes >= `1.18.0`
- Kustomize = `v3.0.X`


## Image repository and tag

* Prometheus Operator image: `quay.io/prometheus-operator/prometheus-operator:v0.50.0`
* Prometheus Operator repository: [https://github.com/prometheus-operator/prometheus-operator](https://github.com/prometheus-operator/prometheus-operator)


## Configuration

Fury distribution Prometheus Operator is deployed with the following configuration:
- Replica number: `1`
- Requires `50Gi` storage (with default storage provider)
- Logging to stderr is enabled
- Resource limits are `200m` for CPU and `200Mi` for memory
- Listens on port `8080`


## Deployment

You can deploy Prometheus Operator by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```


## Deploying Prometheus

Once Prometheus Operator is deployed, you can deploy Prometheus and Alertmanager
instances through Operator's CRDs. Then you will be able to monitor and get
alerts about the services deployed on your Kubernetes cluster. To learn how to
deploy Prometheus via Operator please see
[prometheus-operated](../prometheus-operated) documentation. To learn how to
deploy Alertmanager please see [alertmanager-operated](../alertmanager-operated)
documentation.


## License

For license details please see [LICENSE](../../LICENSE)
