<h1>
    <img src="https://github.com/sighupio/fury-distribution/blob/main/docs/assets/fury-epta-white.png?raw=true" align="left" width="90" style="margin-right: 15px"/>
    Kubernetes Fury Monitoring
</h1>

![Release](https://img.shields.io/badge/Latest%20Release-v2.0.1-blue)
![License](https://img.shields.io/github/license/sighupio/fury-kubernetes-monitoring?label=License)
![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack&label=Slack)

<!-- <KFD-DOCS> -->

**Kubernetes Fury Monitoring** provides a fully-fledged monitoring stack for the
[Kubernetes Fury Distribution (KFD)][kfd-repo]. This module extends and improves upon the [Kube-Prometheus][kube-prometheus-link] project.

If you are new to KFD please refer to the [official documentation][kfd-docs] on how to get started with KFD.

## Overview

This module is designed to give you full control and visibility over your
cluster operations. Metrics from the cluster and the applications are collected
and clean analytics are offered via a visualization platform, [Grafana][grafana-link].

The centerpiece of this module is the [`prometheus-operator`], which offers the
easy deployment of the following as controllers:

- [Prometheus][prometheus-link]: An open-source monitoring and alerting toolkit for cloud-native applications
- [Alertmanager][alertmanager-link]: Manages alerts sent by the Prometheus server and route them through receiver integrations such as email, Slack, or PagerDuty
- [ServiceMonitor][servicemonitor-link]: Declaratively specifies how groups of services should be monitored, by automatically generating Prometheus scrape configuration based on the definition

Since the export of certain metrics can be heavily cloud-provider specific, we
provide a bunch of cloud-provider specific configuration. The setups we
currently support include:

- Google Kubernetes Engine (GKE)
- Azure Kubernetes Service (AKS)
- Elastic Kubernetes Service (EKS)
- on-premises or self-managed cloud clusters

Most of the components in this module are deployed in namespace `monitoring`, unless the
functionality requires a permission that forces it to be deployed in the
namespace `kube-system`.

## Packages

Kubernetes Fury Monitoring provides the following packages:

| Package                                                | Version  | Description                                                                                                 |
|--------------------------------------------------------|----------|-------------------------------------------------------------------------------------------------------------|
| [prometheus-operator](katalog/prometheus-operator)     | `0.57.0` | Operator to deploy and manage Prometheus and related resources                                              |
| [prometheus-operated](katalog/prometheus-operated)     | `2.36.1` | Prometheus instance deployed with Prometheus Operator's CRD                                                 |
| [alertmanager-operated](katalog/alertmanager-operated) | `0.24.0` | Alertmanager instance deployed with Prometheus Operator's CRD                                               |
| [blackbox-exporter](katalog/blackbox-exporter)         | `0.24.0` | Prometheus exporter that allows blackbox probing of endpoints over HTTP, HTTPS, DNS, TCP, ICMP and gRPC.    |
| [grafana](katalog/grafana)                             | `8.5.5`  | Grafana deployment to query and visualize metrics collected by Prometheus                                   |
| [kube-proxy-metrics](katalog/kube-proxy-metrics)       | `0.12.0` | RBAC proxy to securely expose kube-proxy metrics                                                            |
| [kube-state-metrics](katalog/kube-state-metrics)       | `2.5.0`  | Service that generates metrics from Kubernetes API objects                                                  |
| [node-exporter](katalog/node-exporter)                 | `1.3.1`  | Prometheus exporter for hardware and OS metrics exposed by \*NIX kernels                                    |
| [prometheus-adapter](katalog/prometheus-adapter)       | `0.9.1`  | Kubernetes resource metrics, custom metrics, and external metrics APIs implementation.                      |
| [thanos](katalog/thanos)                               | `0.24.0` | Thanos is a high-availability Prometheus setup that provides long term storage via an external object store |
| [x509-exporter](katalog/x509-exporter)                 | `3.2.0`  | Provides monitoring for certificates                                                                        |

### Integration with cloud providers

One of the following components can be used to enable service monitoring in each
cloud environment:

| Component                        | Description                                                                                                    |
|----------------------------------|----------------------------------------------------------------------------------------------------------------|
| [aks-sm](katalog/aks-sm)         | ServiceMonitor to collect Kubernetes components metrics from AKS                                               |
| [gke-sm](katalog/gke-sm)         | ServiceMonitor to collect Kubernetes components metrics from GKE                                               |
| [eks-sm](katalog/eks-sm)         | ServiceMonitor to collect Kubernetes components metrics from EKS                                               |
| [kubeadm-sm](katalog/kubeadm-sm) | ServiceMonitors, Prometheus rules and alerts for Kubernetes components of self-managed or on-premises clusters |

Please refer the individual package documentation for further details.

## Compatibility

| Kubernetes Version |   Compatibility    |                        Notes                        |
| ------------------ | :----------------: | --------------------------------------------------- |
| `1.21.x`           | :white_check_mark: | No known issues                                     |
| `1.22.x`           | :white_check_mark: | No known issues                                     |
| `1.24.x`           | :white_check_mark: | No known issues                                     |

Check the [compatibility matrix][compatibility-matrix] for additional information about previous releases of the modules.

## Usage

### Prerequisites

|            Tool             |  Version  |                                                                          Description                                                                           |
| --------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [furyctl][furyctl-repo]     | `>=0.6.0` | The recommended tool to download and manage KFD modules and their packages. To learn more about `furyctl` read the [official documentation][furyctl-repo]. |
| [kustomize][kustomize-repo] | `>=3.5.0` | Packages are customized using `kustomize`. To learn how to create your customization layer with `kustomize`, please refer to the [repository][kustomize-repo]. |

## Deployment

1. List the packages you want to deploy and their version in a `Furyfile.yml`

```yaml
versions:
 monitoring: v2.0.1

bases:
    - name: monitoring/prometheus-operator
    - name: monitoring/prometheus-operated
    - name: monitoring/alertmanager-operated
    - name: monitoring/blackbox-exporter
    - name: monitoring/kube-proxy-metrics
    - name: monitoring/kube-state-metrics
    - name: monitoring/grafana
    - name: monitoring/node-exporter
    - name: monitoring/prometheus-adapter
    - name: monitoring/x509-exporter
```

Along with the primary components, include one of the following components,
based on the cloud provider for service monitoring:

- ServiceMonitor for AWS EKS cluster

```yaml
  ...
  - name: monitoring/eks-sm
```

- ServiceMonitor for Azure AKS cluster

```yaml
  ...
  - name: monitoring/aks-sm
```

- ServiceMonitor for GCP GKE cluster

```yaml
  ...
  - name: monitoring/gke-sm
```

- ServiceMonitor for on-premises and self-managed cluster

```yaml
  ...
  - name: monitoring/kubeadm-sm
```

> See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/monitoring`.

4. To deploy the packages to your cluster, define a `kustomization.yaml` with the
following content:

```yaml
bases:
    - ./vendor/katalog/monitoring/prometheus-operator
    - ./vendor/katalog/monitoring/prometheus-operated
    - ./vendor/katalog/monitoring/alertmanager-operated
    - ./vendor/katalog/monitoring/blackbox-exporter
    - ./vendor/katalog/monitoring/kube-proxy-metrics
    - ./vendor/katalog/monitoring/kube-state-metrics
    - ./vendor/katalog/monitoring/grafana
    - ./vendor/katalog/monitoring/node-exporter
    - ./vendor/katalog/monitoring/prometheus-adapter
    - ./vendor/katalog/monitoring/x509-exporter
```

Include in the `kustomization` also the ServiceMonitor package specific to each
service provider as follows:

- For AWS EKS

``` yaml
  ...
  - ./vendor/katalog/monitoring/eks-sm

```

- For GCP GKE

``` yaml
  ...
  - ./vendor/katalog/monitoring/gke-sm

```

- For Azure AKS

``` yaml
  ...
  - ./vendor/katalog/monitoring/aks-sm

```

- For on-premises and self-managed

``` yaml
  ...
  - ./vendor/katalog/monitoring/kubeadm-sm

```

5. To deploy the packages to your cluster, execute:

```shell
kustomize build . | kubectl apply -f - --server-side
```

## Examples

To see examples on how to customize Fury Kubernetes Monitoring packages, please
go to [examples](examples) directory.

<!-- Links -->

[kube-prometheus-link]: https://github.com/prometheus-operator/kube-prometheus
[prometheus-link]: https://github.com/prometheus/prometheus
[alertmanager-link]: https://github.com/prometheus/alertmanager
[servicemonitor-link]: https://github.com/prometheus-operator/prometheus-operator#customresourcedefinitions
[grafana-link]: https://grafana.com/
[compatibility-matrix]: https://github.com/sighupio/fury-kubernetes-monitoring/blob/main/docs/COMPATIBILITY_MATRIX.md
[kfd-repo]: https://github.com/sighupio/fury-distribution
[furyctl-repo]: https://github.com/sighupio/furyctl
[kustomize-repo]: https://github.com/kubernetes-sigs/kustomize
[kfd-docs]: https://docs.kubernetesfury.com/docs/distribution/
[metrics-api]: https://github.com/kubernetes/metrics

<!-- </KFD-DOCS> -->

<!-- <FOOTER> -->

## Contributing

Before contributing, please read first the [Contributing Guidelines](docs/CONTRIBUTING.md).

### Reporting Issues

In case you experience any problem with the module, please [open a new issue](https://github.com/sighupio/fury-kubernetes-networking/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->
