# Fury Kubernetes Monitoring

This repo contains all components necessary to deploy monitoring tools on top of
Kubernetes. We use Prometheus, a very popular open source monitoring and
alerting toolkit for cloud-native applications. You can monitor both cluster
itself and applications deployed on cluster via Prometheus. Alertmanager which
makes part of Prometheus stack, handles alerts sent by Prometheus server and let
you manage alerts flexibly and route them through receiver integrations such as
email, Slack or PagerDuty. Thanks to the components in the Fury Kubernetes
Monitoring stack, you're going to have full control on your cluster. On
Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus
instances and to manage service monitoring and alerts. This repo contains a
package to deploy Prometheus Operator and other packages to deploy Prometheus
instances, rules, alerts and exporters. Packages with `-operated` postfix are
deployed via Operator's CRD, therefore you need Prometheus Operator up and
running to be able to deploy them.


## Requirements

All packages in this repository have following dependencies, for package
specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.10.0`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v1`

## Examples

To see examples on how to customize Fury distribution with kustomize please go to [examples](examples)


##  Monitoring Packages

Following packages are included in Fury Kubernetes Monitoring katalog. All
resources in these repositories are going to be deployed in `monitoring`
namespace in your Kubernetes cluster.

- [prometheus-operator](katalog/prometheus-operator): Operator to deploy and
  manage Prometheus and related resources.
- [prometheus-operated](katalog/prometheus-operated): Prometheus instance
  deployed with Prometheus Operator's CRD.
- [alertmanager-operated](katalog/alertmanager-operated): Alertmanager instance
  deployed with Prometheus Operator's CRD.
- [grafana](katalog/grafana): Grafana deployment to query and visualize metrics
  collected by Prometheus.
- [gcp-sm](katalog/gcp-sm): Service Monitor to collect metrics from GKE
  cluster's kubelet components.
- [kubeadm-sm](katalog/kubeadm-sm): Service Monitors, Prometheus rules and
  alerts for your Kubernetes cluster control plane, kubelet and CoreDNS.
- [kube-state-metrics](katalog/kube-state-metrics): Service Monitor for
  Kubernetes objects such as Deployments, Nodes and Pods.
- [node-exporter](katalog/node-exporter): Service Monitor for hardware and OS
  metrics exposed by \*NIX kernels.


You can click on each package to see its documentation.


## License

For license details please see [LICENSE](https://sighup.io/fury/license)

