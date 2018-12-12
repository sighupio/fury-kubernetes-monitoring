# Kubeadm Sm Katalog

This package provides monitoring for following Kubernetes components:
- kube-control-manager
- coredns
- kubelet
- kube-scheduler

These are components needed to deliver a functioning Kubernetes cluster. If you want to learn more about these components please follow the ufficial [documentation](https://kubernetes.io/docs/concepts/overview/components/) of Kubernetes.


## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`


## Image repository and tag
There is no image used since this packages provides only ServiceMonitor resource for Prometheus. 


## Configuration

Prometheus scrapes Kubernetes component metrics on port `metrics` with following intervals:
- kube-control-manager: `30s`
- coredns: `15s`
- kubelet: `15s` (port `http-metrics`)
- kube-scheduler: `30s`


## Alerts

Followings are predefined alerts that Prometheus can send alert notifications for, if it's configured with an AlertManager.
 
### kubernetes-absent-kubeadm  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| KubeControllerManagerDown | This alert fires if Prometheus target discovery was not able to reach the kube-controller-manager in the last 15 minutes. | critical | 15m |
| KubeSchedulerDown | This alert fires if Prometheus target discovery was not able to reach the kube-scheduler in the last 15 minutes. | critical | 15m |
| KubeClientCertificateExpiration | This alert fires when the Kubernetes API client certificate is expiring in less than 7 days. | warning |  |
| KubeClientCertificateExpiration | This alert fires when the Kubernetes API client certificate is expiring in less than 1 day. | critical |  |


 
### coredns.rules  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| CoreDNSPanic | This alert fires if CoreDNS total panic count increased by at least 1 in the last 10 minutes. | warning |  |
| CoreDNSRequestsLatency | This alert fires if CoreDNS 99th percentile requests latency was higher than 100ms in the last 10 minutes. | warning | 10m |
| CoreDNSHealthRequestsLatency | This alert fires if CoreDNS 99th percentile health requests latency was higher than 10ms in the last 10 minutes. | warning | 10m |
| CoreDNSProxyRequestsLatency | This alert fires if CoreDNS 99th percentile proxy requests latency was higher than 500ms in the last 10 minutes. | warning | 10m |


 
### etcd3  
| Parameter | Description | Severity | Interval | 
|------|-------------|----------|:-----:|
| EtcdInsufficientMembers | This alert fires if less than half of Etcd cluster members were online in the last 3 minutes. | critical | 3m |
| EtcdNoLeader | This alert fires if the Etcd cluster had no leader in the last minute. | critical | 1m |
| EtcdHighNumberOfLeaderChanges | This alert fires if the Etcd cluster changed leader more than 3 times in the last hour. | warning |  |
| EtcdHighNumberOfFailedProposals | This alert fires if there were more than 5 proposal failure in the last hour. | warning |  |
| EtcdHighFsyncDurations | This alert fires if the WAL fsync 99th percentile latency was higher than 0.5s in the last 10 minutes. | warning | 10m |
| EtcdHighCommitDurations | This alert fires if the backend commit 99th percentile latency was higher than 0.25s in the last 10 minutes. | warning | 10m |


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
