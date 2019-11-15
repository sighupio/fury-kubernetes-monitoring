# Fury Kubernetes Monitoring

This repository contains all components necessary to deploy monitoring tools on
top of Kubernetes. We use [Prometheus](https://prometheus.io/), a very popular open source monitoring and
alerting toolkit for cloud-native applications. You can monitor both cluster
itself and applications deployed on cluster via Prometheus. Alertmanager which
makes part of Prometheus stack, handles alerts sent by Prometheus server and let
you manage alerts flexibly and route them through receiver integrations such as
email, Slack or PagerDuty. Thanks to the components in the Fury Kubernetes
Monitoring stack, you're going to have full control on your cluster. On
Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus
instances and to manage service monitoring and alerts. This repository contains
a package to deploy Prometheus Operator and other packages to deploy Prometheus
instances, rules, alerts and exporters. Packages with `-operated` postfix are
deployed via Operator's CRD, therefore you need Prometheus Operator up and
running to be able to deploy them.

##  Monitoring Packages

Following packages are included in Fury Kubernetes Monitoring katalog. All
resources in these repositories are going to be deployed in `monitoring`
namespace in your Kubernetes cluster.

- [prometheus-operator](katalog/prometheus-operator): Operator to deploy and
  manage Prometheus and related resources. Version: **0.29.0**
- [prometheus-operated](katalog/prometheus-operated): Prometheus instance
  deployed with Prometheus Operator's CRD. Version: **2.7.1**
- [alertmanager-operated](katalog/alertmanager-operated): Alertmanager instance
  deployed with Prometheus Operator's CRD, pay attention to change the [config](katalog/alertmanager-operated/secret.yml) as needed. Version: **0.16.0**
- [grafana](katalog/grafana): Grafana deployment to query and visualize metrics
  collected by Prometheus. Version: **5.3.4**
- [aks-sm](katalog/aks-sm): Service Monitor to collect Kubernetes components
  metrics from AKS
- [gke-sm](katalog/gke-sm): Service Monitor to collect Kubernetes components
  metrics from GKE
- [kubeadm-sm](katalog/kubeadm-sm): Service Monitors, Prometheus rules and
  alerts for Kubernetes components of unmanaged/on-promise clusters.
- [kube-state-metrics](katalog/kube-state-metrics): Service Monitor for
  Kubernetes objects such as Deployments, Nodes and Pods. Version: **1.5.0**
- [node-exporter](katalog/node-exporter): Service Monitor for hardware and OS
  metrics exposed by \*NIX kernels. Version: **0.16.0**

You can click on each package to see its documentation.

## Requirements

All packages in this repository have following dependencies, for package
specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.10.0`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install
  Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) = `v1.0.10`


## Compatibility

| Module Version / Kubernetes Version | 1.14.X             | 1.15.X             | 1.16.X             |
|-------------------------------------|:------------------:|:------------------:|:------------------:|
| v1.0.0                              |                    | :white_check_mark: |                    |
| v1.1.0                              | :white_check_mark: | :white_check_mark: | :x:                |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible


## Deployment

To start using Fury Kubernetes Monitoring, you need to use
[furyctl](https://github.com/sighup-io/furyctl/blob/master/README.md)
and create a `Furyfile.yml` with the list of all the packages that you want to
download.

You can download the packages for a full monitoring stack including
Prometheus Operator, Prometheus, Alertmanager, node-exporter, kube-state-metrics
and Grafana using the following `Furyfile.yml` :
```yaml
bases:
  - name: monitoring/prometheus-operator
    version: master
  - name: monitoring/prometheus-operated
    version: master
  - name: monitoring/alertmanager-operated
    version: master
  - name: monitoring/node-exporter
    version: master
  - name: monitoring/kube-state-metrics
    version: master
  - name: monitoring/grafana
    version: master
```
and execute
```bash
$ furyctl install
```
to download the packages under `./vendor/katalog/monitoring`.

See `furyctl`
[documentation](https://github.com/sighup-io/furyctl/blob/master/README.md)
for details about `Furyfile.yml` format.

To deploy the packages to your cluster, define a `kustomization.yaml` with the
following content:
```yaml
bases:
- ./vendor/katalog/monitoring/prometheus-operator
```
and execute
```shell
$ kustomize build . | kubectl apply -f -
```
to deploy Prometheus Operator and create the Custom Resource Definitions needed
by the other packages.

Now you can add the other packages to `kustomization.yaml`, the final file will
have the following content:
```yaml
bases:
- ./vendor/katalog/monitoring/prometheus-operator
- ./vendor/katalog/monitoring/prometheus-operated
- ./vendor/katalog/monitoring/alertmanager-operated
- ./vendor/katalog/monitoring/node-exporter
- ./vendor/katalog/monitoring/kube-state-metrics
- ./vendor/katalog/monitoring/grafana
```

See `kustomize`
[documentation](https://github.com/kubernetes-sigs/kustomize/blob/master/docs/README.md)
for details about `kustomization.yaml` format.

To deploy all the packages to your cluster, execute the following command:
```bash
$ kustomize build . | kubectl apply -f -
```

The following cluster architectures are supported to obtain metrics from
Kubernetes components:
- on-premise or unmanaged cloud clusters
- Google Kubernetes Engine (GKE)
- Azure Kubernetes Service (AKS)

### On-premise or unmanaged cloud clusters
- Add `monitoring/kubeadm-sm` to `Furyfile.yml`.
- Download package with `furyctl install`
- Add `./vendor/katalog/monitoring/kubeadm-sm` to `kustomization.yaml`.
- Deploy package with `kustomize build . | kubectl apply -f -`

### Google Kubernetes Engine (GKE)
- Add `monitoring/gke-sm` to `Furyfile.yml`.
- Download package with `furyctl install`
- Add `./vendor/katalog/monitoring/gke-sm` to `kustomization.yaml`.
- Deploy package with `kustomize build . | kubectl apply -f -`

### Azure Kubernetes Service (AKS)
- Add `monitoring/aks-sm` to `Furyfile.yml`.
- Download package with `furyctl install`
- Add `./vendor/katalog/monitoring/aks-sm` to `kustomization.yaml`.
- Deploy package with `kustomize build . | kubectl apply -f -`

If you need to customize our packages you can do it with `kustomize`. It lets
you create customized Kubernetes resources based on other Kubernetes resource
files, leaving the original YAML untouched and usable as is. To learn how to
create you customization layer with it please see the `kustomize`
[repository](https://github.com/kubernetes-sigs/kustomize).

For further details please refer to the single package directories in this
repository.

## Examples

To see examples on how to customize Fury Kubernetes Monitoring packages please
go to [examples](examples) directory.

## License

For license details please see [LICENSE](https://sighup.io/fury/license)
