# Alertmanager Operated

Alertmanager handles alerts sent by Prometheus server and routes them to
configured receiver integrations such as email, Slack, PageDuty, or OpsGenie. It
helps you to manage alerts flexibly with its grouping, inhibition
and silencing features.

Fury Prometheus deployment (see [prometheus-operated](../prometheus-operated))
is already configured to automatically discover Alertmanager instances deployed
with this package.


## Image repository and tag

* Alertmanager image: `quay.io/prometheus/alertmanager:v0.22.2`
* Alertmanager repository: [https://github.com/prometheus/alertmanager](https://github.com/prometheus/alertmanager)
* Alertmanager documentation: [https://prometheus.io/docs/alerting/alertmanager](https://prometheus.io/docs/alerting/alertmanager)


## Requirements

- Kubernetes >= `1.18.0`
- Kustomize >= `v3`
- [prometheus-operator](../prometheus-operator)


## Configuration

Fury distribution Alertmanager is deployed with the following configuration:
- Replica number: `3`
- Listens on port `9093`
- Alertmanager metrics are scraped by Prometheus every `30s`


## Deployment

Before deploying this, please take a look at how to configure the alertmanager [the
right way](../../examples/alertmanger-configuration).

You can deploy Alertmanager by running the following command in the root of the
project:

```shell
kustomize build | kubectl apply -f -
```

### Accessing Alertmanager UI

You can access to Alertmanager dashboard by port-forwarding on port 9093:

```shell
kubectl port-forward svc/alertmanager-main 9093:9093 --namespace monitoring
```

Now you can go to [http://127.0.0.1:9093](http://127.0.0.1:9093) on your browser to see and manage your
alerts.

To learn how to add external URL to acess Alertmanager please see the
[example](../../examples/prometheus-alertmanager-externalUrl).


## License

For license details please see [LICENSE](../../LICENSE)
