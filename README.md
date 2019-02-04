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
- [Furyctl](https://github.com/sighup-io/fury-utilities/blob/master/docs/FURY.md/#Furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v1`


## Deployment

To start using Fury Kubernetes Monitoring tools first you need to download packages. [furyctl](https://github.com/sighup-io/fury-utilities/blob/master/docs/FURY.md/#Furyctl) 
is the package manager for Fury distribution. In order to download packages you want to use, you must
create a `Furyfile.yml` where you gonna list desired packages from monitoring katalog. For further details 
about `furyctl`please follow the link above. For monitoring components, you need at least 
[prometheus-operator](katalog/prometheus-operator) and [prometheus-operated](katalog/prometheus-operated) 
to be deployed for other packages to be deployed. So your basic `Furyfile` must have at least these 2 packages:

```
bases:
  - name: monitoring/prometheus-operator
    version: master
  - name: monitoring/prometheus-operator
    version: master
```

Katalog packages goes under `bases` section, in the form `katalog_name/package_name`.  Once you've created your Furyfile, 
execute the following command from the same directory where your Furyfile is stored:

`$ furyctl install`

If everything goes well, packages will be located under `./vendor/katalog/monitoring` directory of your current directory. 

You can add other packages as well based on your needs, following packages are going to work with every kind 
of cloud setup: 

- [alertmanager-operated](katalog/alertmanager-operated)
- [grafana](katalog/grafana)
- [kube-state-metrics](katalog/kube-state-metrics)
- [node-exporter](katalog/node-exporter) 

Instead, to obtain metrics for Kubernetes cluster components you must add one of the following packages respect to your cloud setup:

- If you have access to your master node (e.g. on-premise cloud): [kubeadm-sm](katalog/kubeadm-sm)
- Otherwise (e.g. a public cloud service): [gcp-sm](katalog/gcp-sm)

You can find necessary details about each package under its own directory in this repo.

Now you got the monitoring katalog packages, you can deploy them. At this point you have 2 options:

1. You can directly deploy our manifests which are ready to use. For each package you have, you can execute the following
command (from directory where your vendor dir is located) which points to the package directory:

`$ kustomize build vendor/katalog/monitoring/prometheus-operator | kubectl apply -f -`

2. If you need to customize our packages you can do it with `Kustomize`. It lets you create 
customized Kubernetes resources based on other Kubernetes resource files, leaving the original 
YAML untouched and usable as is. To learn how to create you customization layer with it
please see the Kustomize [repo](https://github.com/kubernetes-sigs/kustomize).

Each monitoring package repo explains how to deploy and access(where it's possible) the component. For further details please refer to
the single package directories in this repo.

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

