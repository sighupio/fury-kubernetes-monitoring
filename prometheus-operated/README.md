# Prometheus Operated Katalog

Prometheus Operated deploys Prometheus instance(s) via Prometheus CRD (defined by Prometheus Operator.) as explained in the monitoring documentation. To learn how to deploy [prometheus-operator]() please follow it's documentation.

Prometheus is a monitoring tool to collect metric based time series data and provides a functional expression language that lets the user select and aggregate time series data in real time. Prometheus's expression browser(it's web UI) make it possible to analyse queried data as a graph or view it as tabular data, but it's also possible to integrate it with other time-series analytics tools like Grafana. In Fury monitoring katalog we provide Grafana integration. To learn how to deploy Grafana to visualize your time-series data collected by Prometheus, please visit the [grafana]() package's documentation.

Prometheus CRD occupies deploying Prometheus instances. Configuration of entities to monitor is realized via ServiceMonitor CRD. The ServiceMonitor resource specifies how metrics can be retrieved from a set of services exposing them in a common way. A Prometheus resource object can dynamically include ServiceMonitor objects by their labels. The Operator configures the Prometheus instance to monitor all services covered by included ServiceMonitors and keeps this configuration synchronized with any changes happening in the cluster.

## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator]()


## Image repository and tag

* Prometheus image : `quay.io/prometheus/prometheus:v2.4.3`
* Prometheus documenatation: [https://prometheus.io/docs/introduction/overview/]()


## Configuration

Fury distribution Prometheus is deployed with following configuration:
- Replica number : `1` 
- Retention for `30` days
- Requires `50Gi` storage(with default storage type of Provider)
- Listens on port `9090` 
- Alert manager endpoint set to `alertmanager-main` 


## Deployment

You can deploy Prometheus Operated by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`

To learn how to customize it for your needs please see the [#Examples]() section.

### Accessing Prometheus UI

You can access to Prometheus expression browser by port-forwarding on port 9090:

`kubectl port-forward svc/prometheus-k8s 9090:9090`

Now if you go to `http://127.0.0.1:9090` on your browser you can execute queries and visualize query results.


### Service Monitoring

Service monitoring is decoupled from deployment of Prometheus instances. While Prometheus CRD handles deployment of Prometheus instances, ServiceMonitor CRD handles to retrieve metrics from a set of services.

Fury Prometheus Operator package deploys Prometheus to monitor both cluster itself and applications deployed on cluster. The Operator configures the Prometheus instance to monitor all services covered by included ServiceMonitors and keeps this configuration synchronized with any changes happening in the cluster.

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

ServiceMonitors belonging to a Prometheus setup are selected vian labels. When deploying the Prometheus instance, the Operator configures it according to the matching service monitors. It defines that all ServiceMonitor CRDs with the label `app = frontend` should be included into the server's configuration.

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



### Record and Alert rules

Prometheus scrapes time series data identified by metric name and key/value pairs. Aggregated data let us to have insight about the state and the sanity of our system. In the light of these informations we can take measures before problems occur or we can take actions once they occur.

Prometheus has its own querying language [PromQL](), to select and aggregate time series data in real time. Some query expressions can be computationally expensive but used frequently. Prometheus let you precompute these expressions and save the result as a new set of time series, so they can be accessed much more faster. These are called as * Recording Rules *  and they are useful for dashboards which need to evaluate same expression again and again.

Prometheus also allow you to define * Alert Rules * which are alert conditions based on PromQL expressions which then will be used by AlertManager to send notifications about firing alerts to an external service.

So basically what does prometheus is scraping metrics from jobs/exporters, storing those data locally and then running defined rules over the data to aggregate/record new time series or generate alerts.  
You can define your own recording and alerting rules via PrometheusRule CRD, in a Kubernetes-native, declarative manner. To learn more about rules and alerts please visit [alertmanager-operated]() package's documentation.


## Alerts

Followings are predefined alerts that Prometheus can send alert notifications for, if it's configured with an AlertManager.
 
### kubernetes-apps  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| KubePodCrashLooping | This alert fires if the per-second rate of the total number of restart of a given pod in a 15 minutes time window was above 0 in the last hour, i.e. the pod is stuck in a crash loop. | critical | 1h |
| KubePodNotReady | This alert fires if at least one pod was stuck in the Pending or Unknown phase in the last hour. | critical | 1h |
| KubeDeploymentGenerationMismatch | This alert fires if in the last hour a deployment's observed generation (the revision number recorded in the object status) was different from the metadata generation (the revision number in the deployment metadata). | critical | 15m |
| KubeDeploymentReplicasMismatch | This alert fires if a deployment's replicas number specification was different from the available replicas in the last hour. | critical | 1h |
| KubeStatefulSetReplicasMismatch | This alert fires if a deployment's replicas number specification was different from the available replicas in the last hour. | critical | 15m |
| KubeStatefulSetGenerationMismatch | This alert fires if a StatefulSet's replicas number specification was different from the available replicas in the 15 minutes. | critical | 15m |
| KubeDaemonSetRolloutStuck | This alert fires if the percentage of DaemonSet in the ready phase was less than 100% in the last 15 minutes. | critical | 15m |
| KubeDaemonSetNotScheduled |  This alert fires if the desired number of scheduled DaemonSet was higher than the number of currently scheduled DaemonSet in the last 10 minutes.  | warning | 10m |
| KubeDaemonSetMisScheduled | This alert fires if at least one DaemonSet was running where it was not supposed to run in the last 10 minutes. | warning | 10m |
| KubeCronJobRunning |  This alert fires if at least one CronJob took more than one hour to complete. | warning | 1h |
| KubeJobCompletion | This alert fires if at least on Job took more than one hour to complete. | warning | 1h |
| KubeJobFailed | This alert fires if at least one Job failed in the last hour. | warning | 1h |
| KubeLatestImageTag | This alert fires if there are images deployed in the cluster tagged with `:latest` and this is really dangerous | warning | 1h |


 
### kube-prometheus-node-alerting.rules  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| NodeCPUSaturating | This alert fires if, for a given instance, CPU utilisation and saturation were higher than 90% in the last 30 minutes. | warning | 30m |
| NodeCPUStuckInIOWait | This alert fires if CPU time in IOWait mode calculated on a 5 minutes window for a given instance was more than 50% in the last 15 minutes. | warning | 15m |
| NodeMemoryRunningFull | This alert fires if memory utilisation on a given node was higher than 85% in the last 30 minutes. | warning | 30m |
| NodeDiskRunningFull | This alert fires if in the last 30 minutes the filesystem usage was more than 85% and, based on a linear prediction on the volume usage in the last 6 hours, the volume will be full in 24 hours. | warning | 30m |
| NodeDiskRunningFull | This alert fires if in the last 10 minutes the filesystem usage was more than 85% and, based on a linear prediction on the volume usage in the last 30 minutes, the volume will be full in 2 hours. | critical | 10m |
| NodeFilesystemInodeUsageCritical | This alert fires if the available inodes in a given filesystem were less than 10% in the last minute. | critical | 1m |
| NodeFilesystemInodeFullInFourDays | This alert fires if, based on a linear prediction on the inodes usage in the last 6 hours, the filesystem will exhaust its inodes in four days. | critical | 5m |
| NodeNetworkDroppingPackets | This alerts fires if a given physical network interface was dropping more than 10 pkt/s in the last 30 minutes. | warning | 30m |




 
### prometheus.rules  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| PrometheusConfigReloadFailed | This alert fires if Prometheus's configuration failed to reload in the last 10 minutes. | warning | 10m |
| PrometheusNotificationQueueRunningFull | This alert fires if Prometheus's alert notification queue is running full, based on a linear prediction on the usage in the last 30 minutes. | warning | 10m |
| PrometheusErrorSendingAlerts | This alert fires if the error rate calculated in a 5 minutes time windows was more than 1% in the last 10 minutes. | warning | 10m |
| PrometheusErrorSendingAlerts | This alert fires if the error rate calculated in a 5 minutes time windows was more than 3% in the last 10 minutes. | critical | 10m |
| PrometheusNotConnectedToAlertmanagers | This alert fires if Prometheus was not connected to at least one Alertmanager in the last 10 minutes. | warning | 10m |
| PrometheusTSDBReloadsFailing | This alert fires if Prometheus had any failure to reload data blocks from disk in the last 12 hours. | warning | 12h |
| PrometheusTSDBCompactionsFailing | This alert fires if Prometheus had any failure to compact sample blocks in the last 12 hours. | warning | 12h |
| PrometheusTSDBWALCorruptions | This alert fires if Prometheus had detected any corruption in the write-ahead log in the last 4 hours. | warning | 4h |
| PrometheusNotIngestingSamples | This alert fires if Prometheus sample ingestion rate calculated on a 5 minutes time window was below or equal to 0 in the last 10 minutes, i.e. Prometheus is failing to ingest samples. | warning | 10m |
| PrometheusTargetScrapesDuplicate | This alert fires if Prometheus was discarding many samples due to duplicated timestamps but different values in the last 10 minutes. | warning | 10m |


 
### general.rules  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| TargetDown | This alert fires if more than 10% of the targets were down in the last 10 minutes. | warning | 10m |
| FdExhaustion | This alert fires if, based on a linear prediction on file descriptors usage in the last hour minutes, the instance will exhaust its file descriptors in 4 hours. | warning | 10m |
| FdExhaustion | This alert fires if, based on a linear prediction on file descriptors usage in the last 10 minutes, the instance will exhaust its file descriptors in one hour. | critical | 10m |
| DeadMansSwitch | This is a DeadMansSwitch meant to ensure that the entire Alerting Pipeline is functional. | none |  |




 
### kubernetes-system  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| KubeNodeNotReady | This alert fires if a given node was not in Ready status in the last hour. | warning | 1h |
| KubeVersionMismatch | This alert fires if the versions of the Kubernetes components were mismatching in the last hour. | warning | 1h |
| KubeClientErrors | This alert fires if the Kubernetes API client error responses rate calculated in a 5 minutes window was more than 1% in the last 15 minutes. | warning | 15m |
| KubeClientErrors | This alert fires if the Kubernetes API client error responses rate calculated in a 5 minutes window was more than 0.1 errors / sec in the last 15 minutes. | warning | 15m |
| KubeletTooManyPods | This alert fires if a given kubelet is running more than 100 pods and is approaching the hard limit of 110 pods per node. | warning | 15m |
| KubeAPILatencyHigh | This alert fires if the API server 99th percentile latency was more than 1 second in the last 10 minutes. | warning | 10m |
| KubeAPILatencyHigh | This alert fires if the API server 99th percentile latency was more than 4 second in the last 10 minutes. | critical | 10m |
| KubeAPIErrorsHigh | This alert fires if the requests error rate calculated in a 5 minutes window was more than 5% in the last 10 minutes. | critical | 10m |


 
### kubernetes-storage  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| KubePersistentVolumeStuck | This alert fires if a given persisten volume was stuck in the Pending or Failed phase in the last hour. | warning | 1h |
| KubePersistentVolumeUsageCritical | This alert fires if the available space in a given PersistentVolumeClaim was less than 10% in the last minute. | critical | 1m |
| KubePersistentVolumeFullInFourDays | This alert fires if, based on a linear prediction on the volume usage in the last 6 hours, the volume will be full in four days. | critical | 5m |
| KubePersistentVolumeInodeUsageCritical | This alert fires if the available inodes in a given PersistentVolumeClaim were less than 10% in the last minute. | critical | 1m |
| KubePersistentVolumeInodeFullInFourDays | This alert fires if, based on a linear prediction on the inodes usage in the last 6 hours, the volume will exhaust its inodes in four days. | critical | 5m |







 
### kubernetes-absent  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| AlertmanagerDown | This alert fires if Prometheus target discovery was not able to reach AlertManager in the last 15 minutes. | critical | 15m |
| KubeAPIDown | This alert fires if Prometheus target discovery was not able to reach kube-apiserver in the last 15 minutes. | critical | 15m |
| KubeStateMetricsDown | This alert fires if Prometheus target discovery was not able to reach kube-state-metrics in the last 15 minutes. | critical | 15m |
| KubeletDown | This alert fires if Prometheus target discovery was not able to reach the kubelet in the last 15 minutes. | critical | 15m |
| NodeExporterDown | This alert fires if Prometheus target discovery was not able to reach node-exporter in the last 15 minutes. | critical | 15m |
| PrometheusDown | This alert fires if Prometheus target discovery was not able to reach Prometheus in the last 15 minutes. | critical | 15m |
| PrometheusOperatorDown | This alert fires if Prometheus target discovery was not able to reach the Prometheus Operator in the last 15 minutes. | critical | 15m |



 
### alertmanager.rules  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| AlertmanagerConfigInconsistent | This alert fires if the configuration of the instances of the Alertmanager cluster were out of sync in the last 5 minutes. | critical | 5m |
| AlertmanagerDownOrMissing | This alert fires if in the last 5 minutes an unexpected number of Alertmanagers were scraped or Alertmanagers disappered from target discovery. | warning | 5m |
| AlertmanagerFailedReload | This alert fires if the Alertmanager's configuration reload failed in the last 10 minutes. | warning | 10m |




 
### kubernetes-resources  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| KubeCPUOvercommit | This alert fires if the cluster-wide CPU requests from pods in the last 5 minutes were so high to not tolerate a node failure. | warning | 5m |
| KubeMemOvercommit | This alert fires if the cluster-wide memory requests from pods in the last 5 minutes were so high to not tolerate a node failure. | warning | 5m |
| KubeCPUOvercommit | This alert fires if the hard limit of CPU resources quota in the last 5 minutes is more than 150% of the available resources, i.e. the hard limit is set too high. | warning | 5m |
| KubeMemOvercommit | This alert fires if the hard limit of memory resources quota in the last 5 minutes is more than 150% of the available resources, i.e. the hard limit is set too high. | warning | 5m |
| KubeQuotaExceeded | This alert fires if a given resource was used for more than 90% of the corresponding hard quota in the last 15 minutes. | warning | 15m |



## Examples

### How do you customize Fury package
[FILL_ME]

### How do you add a new rule
[FILL_ME]

### How do you add a new alert
[FILL_ME]


## License

For license details please see [LICENSE](license_link) 
