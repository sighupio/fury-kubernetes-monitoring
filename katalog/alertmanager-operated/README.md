# Alertmanager Operated

<!-- <KFD-DOCS> -->

Alertmanager handles alerts sent by Prometheus server and routes them to
configured receiver integrations such as email, Slack, PageDuty, or OpsGenie. It
helps you to manage alerts flexibly with its grouping, inhibition
and silencing features.

Fury Prometheus deployment (see [prometheus-operated](../prometheus-operated))
is already configured to automatically discover Alertmanager instances deployed
with this package.

## Image repository and tag

* Alertmanager image: `registry.sighup.io/prometheus/alertmanager:v0.22.2`
* Alertmanager repository: [Alertmanager on Github][am-gh]
* Alertmanager documentation: [Alertmanager Homepage][am-doc]

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator](../prometheus-operator)

## Configuration

Fury distribution Alertmanager is deployed with the following configuration:

- Replica number: `3`
- Listens on port `9093`
- Alertmanager metrics are scraped by Prometheus every `30s`

## Deployment

Before deploying this, please take a look at how to configure the alertmanager [the
right way][example-2].

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

Now you can go to [http://127.0.0.1:9093](http://127.0.0.1:9093) on your browser
to see and manage your alerts.

To learn how to add external URL to access Alertmanager please see the
[example][example].

Links

[am-gh]: https://github.com/prometheus/alertmanager
[am-doc]: https://prometheus.io/docs/alerting/alertmanager
[example]: https://github.com/sighupio/fury-kubernetes-monitoring/examples/prometheus-alertmanager-externalUrl
[example-2]: https://github.com/sighupio/fury-kubernetes-monitoring/examples/alertmanger-configuration

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
