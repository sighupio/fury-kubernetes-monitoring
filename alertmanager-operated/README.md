# Alertmanager Operated Katalog

AlertManager handles alerts sent by Prometheus server and routes them to configured receiver integration such as email, Slack, PageDuty or OpsGenie. It helps you to manage alerts in a flexible manner with it's grouping, inhibition and silencing features.

Alerts are important to diagnose a system's problems and to interfere in time, but if they are not managed well they can cause more frustration and can lead to ignore symptoms of a problem. AlertManager's features help to manage sanely your alerts:

- grouping alert of similare nature ...
- silencing alerts for a given time  ...
- route noitifications to receiver integrations ...

Fury Prometheus deployment(see [prometheus-operated]()) is already configured to automatically discover AlertManager instances(s) deployed with this package and to mount rule files created with PrometheusRule resource.

### Image repository and tag

* Alert Manager image: `quay.io/prometheus/alertmanager:v0.15.3`
* Alert Manager documentation: [https://prometheus.io/docs/alerting/alertmanager/]()


## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator]()
- [prometheus-operated]()



## Configuration

- AlertManager is deployed as a cluster of 3 instances.
- Listens on port 9093


## Alert Rules

From Prometheus [documentation]() :

" *Alerting rules allow you to define alert conditions based on Prometheus expression language expressions and to send notifications about firing alerts to an external service. Whenever the alert expression results in one or more vector elements at a given point in time, the alert counts as active for these elements' label sets.* "



### How do you define an Alert Rule

Prometheus Operater provides PrometheusRule custom resource to define recording and alerting rules. Which is very similar to the original rules file syntax:


```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    prometheus: k8s
    role: alert-rules
  name: prometheus-k8s-rules
  namespace: monitoring
spec:
  groups:
  - name: <alert_name>
    rules:
    - alert: <alert_notification>
      annotations:
        message: <shorter description as summary>
        doc: <longer_expression_about_firing_event>      
        expr: |
        <promql_expression_to_evaluate>
      for: 15m
      labels:
        <key> : <value>
```

An example would be like following, where `groups` is a list of alerts. Alerts in the same group ar evaluted together.

```yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    prometheus: k8s
    role: alert-rules
  name: prometheus-k8s-rules
  namespace: monitoring
spec:
  groups:
    - alert: KubeAPIDown
      annotations:
        message: KubeAPI has disappeared from Prometheus target discovery.
        doc: This alert fires if Prometheus target discovery was not able to reach kube-apiserver in the last 15 minutes.
      expr: |
        absent(up{job="apiserver"} == 1)
      for: 15m
      labels:
        severity: critical
   // other alerts
```

### Record Rules


## Examples


## License

For license details please see [LICENSE](license_link) 
