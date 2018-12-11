This repo is the documentation for Github Fury Kubernetes Monitoring repo. To be able to access the  fury-kubernetes-monitoring packages you must be a Sighup customer. If you're not a customer yet, contact us at info@sighup.io or http://www.sighup.io for info on how to get access!

# AlertManager Operated Katalog

AlertManager handles alerts sent by Prometheus server and routes them to configured receiver integrations such as email, Slack, PageDuty or OpsGenie. It helps you to manage alerts in a flexible manner with it's grouping, inhibition and silencing features.

Alerts are important to diagnose a system's problems and to interfere in time, but if they are not managed well they can cause more frustration and can lead to ignore symptoms of a problem. AlertManager's features help to manage your alerts efficiently:

- grouping alerts of similare nature to avoid alert flooding
- suppressing notifications for certain alerts if some other alerts are already firing
- silencing alerts for a given time when it's needed
- route noitifications to receiver integrations to be notified via your preferred platform

Fury Prometheus deployment(see [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/prometheus-operated)) is already configured to automatically discover AlertManager instances(s) deployed with this package and to mount rule files created with PrometheusRule resources.

### Image repository and tag

* Alert Manager image: `quay.io/prometheus/alertmanager:v0.15.3`
* Alert Manager documentation: [https://prometheus.io/docs/alerting/alertmanager/]()


## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator]()
- [prometheus-operated]()



## Configuration

Fury distribution AlertManager is deployed with following configuration:
- Replica number : `3` 
- Listens on port `9093`
- Metrics are scraped by Prometheus within `30s` intervals


## Deployment

You can deploy AlertManager by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`


### Accessing AlertManager UI

You can access to AlertManager dashboard by port-forwarding on port 9093:

`kubectl port-forward svc/alertmanager-main 9093:9093`

Now you can go to `http://127.0.0.1:9093` on your browser to see and manage your alerts. 

To learn how to add external URL to acess AlertManager please see the [example](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/examples/prometheus-alertmanager-externalUrl).


## Alert Rules

From Prometheus [documentation]() :

" Alerting rules allow you to define alert conditions based on Prometheus expression language expressions and to send notifications about firing alerts to an external service. Whenever the alert expression results in one or more vector elements at a given point in time, the alert counts as active for these elements' label sets. "


### How do you define an Alert Rule

Prometheus Operater provides PrometheusRule custom resource to define alerting rules. Which is very similar to the original rules file syntax.

To learn how to define alert rules please see the [example](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/examples/prometheus-rules).


## License

For license details please see [LICENSE](license_link) 
