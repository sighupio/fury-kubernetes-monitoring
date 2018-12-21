
# Alertmanager Operated Katalog

Alertmanager handles alerts sent by Prometheus server and routes them to configured receiver integrations such as email, Slack, PageDuty or OpsGenie. It helps you to manage alerts in a flexible manner with it's grouping, inhibition and silencing features.

Fury Prometheus deployment (see [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/prometheus-operated)) is already configured to automatically discover Alertmanager instances deployed with this package.


## Image repository and tag

* Alertmanager image: `quay.io/prometheus/alertmanager:v0.15.3`
* Alertmanager documentation: https://prometheus.io/docs/alerting/alertmanager


## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`
- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/prometheus-operator)


## Configuration

Fury distribution AlertManager is deployed with following configuration:
- Replica number : `3` 
- Listens on port `9093`
- Alertmanager metrics are scraped by Prometheus every `30s`


## Deployment

You can deploy Alertmanager by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`


### Accessing Alertmanager UI

You can access to Alertmanager dashboard by port-forwarding on port 9093:

`kubectl port-forward svc/alertmanager-main 9093:9093 --namespace monitoring`

Now you can go to `http://127.0.0.1:9093` on your browser to see and manage your alerts. 

To learn how to add external URL to acess AlertManager please see the [example](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/examples/prometheus-alertmanager-externalUrl).


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
