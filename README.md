# Fury Kubernetes Monitoring
 
This repo contains all components necessary to deploy monitoring tools on top of Kubernetes. We use Prometheus, a very popular open source monitoring and alerting toolkit for cloud-native applications. You can monitor both cluster itself and applications deployed on cluster via Prometheus. AlertManager which makes part of Prometheus stack, handles alerts sent by Prometheus server and let you manage alerts flexibly and route them through receiver integrations such as email, Slack or PagerDuty. Thanks to the components in the Fury Kubernetes Monitoring stack, you're going to have full control on your cluster. On Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus instances and to manage Service Monitoring and Alerts. This repo contains a package to deploy Prometheus Operator and other packages to deploy Prometheus instances, rules, alerts and exporters. Packages with `-operated` postfix are deployed via Operator's CRD, therefore you need Prometheus Operator up and running to be able to deploy them.  


## Requirements

All packages in this repository have following dependencies, for package specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.10`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v1` 
`

## Examples

To see examples on how to customize Fury distribution with kustomize please go to [examples](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/examples)


##  Monitoring Packages 

Following packages are included in Fury Kubernetes Monitoring katalog. All resources in these repositories are going to be deployed in `monitoring` namespace in your Kubernetes cluster.

- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator) : Operator to deploy and manage Prometheus and related resources.
- [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operated) : Prometheus instance deployed with Prometheus Operator's CRD.
- [alertmanager-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/alertmanager-operated) : Alertmanager instance deployed with Prometheus Operator's CRD.
- [grafana](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/grafana) : Grafana deployment to query and visualize metrics collected by Prometheus.
- [gcp-sm](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/gcp-sm) : Service Monitor to collect metrics from GKE cluster's kubelet components.
- [kubeadm-sm](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/kubeadm-sm) : Service Monitors, Prometheus rules and alerts for your Kubernetes cluster control plane, kubelet and coreDNS
- [kube-state-metrics](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/kube-state-metrics) : Service Monitor for Kubernetes objects such as Deployments, Nodes and Pods.
- [node-exporter](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/node-exporter) : Service Monitor for hardware and OS metrics exposed by \*NIX kernels.


You can click on each package to see its documentation.


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 

