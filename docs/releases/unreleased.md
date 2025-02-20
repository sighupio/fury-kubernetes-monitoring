# Monitoring Core Module Release vTBD

Welcome to the latest release of the `monitoring` core module of the [`Kubernetes Fury Distribution`](https://github.com/sighupio/fury-distribution), maintained by team SIGHUP.

This is a maintenance release that includes bug fixes and improvements to the existing components.

## Component Images 🚢

| Component             | Supported Version                                                                                          | Previous Version             |
| --------------------- | ---------------------------------------------------------------------------------------------------------- | ---------------------------- |
| `alertmanager`        | [`v0.26.0`](https://github.com/prometheus/alertmanager/releases/tag/v0.26.0)                               | No update                    |
| `blackbox-exporter`   | [`v0.25.0`](https://github.com/prometheus/blackbox_exporter/releases/tag/v0.25.0)                          | No update                    |
| `grafana`             | [`v11.3.0`](https://github.com/grafana/grafana/releases/tag/v11.3.0)                                       | No update                    |
| `kube-rbac-proxy`     | [`v0.18.1`](https://github.com/brancz/kube-rbac-proxy/releases/tag/v0.18.1)                                | No update                    |
| `kube-state-metrics`  | [`v2.13.0`](https://github.com/kubernetes/kube-state-metrics/releases/tag/v2.13.0)                         | No update                    |
| `node-exporter`       | [`v1.8.2`](https://github.com/prometheus/node_exporter/releases/tag/v1.8.2)                                | No update                    |
| `prometheus-adapter`  | [`v0.12.0`](https://github.com/kubernetes-sigs/prometheus-adapter/releases/tag/v0.12.0)                    | No update*                   |
| `prometheus-operator` | [`v0.76.2`](https://github.com/prometheus-operator/prometheus-operator/releases/tag/v0.76.2)               | No update                    |
| `prometheus`          | [`v2.54.1`](https://github.com/prometheus/prometheus/releases/tag/v2.54.1)                                 | No update                    |
| `thanos`              | `v0.34.0` **DEPRECATED**: see below.                                                                       | No update                    |
| `x509-exporter`       | [`v3.17.0`](https://github.com/enix/x509-certificate-exporter/releases/tag/v3.17.0)                        | No update                    |
| `karma`               | [`v0.113`](https://github.com/prymitive/karma/releases/tag/v0.113)                                         | No update                    |
| `mimir`               | [`v2.14.0`](https://github.com/grafana/mimir/releases/tag/mimir-2.14.0)                                    | No update                    |
| `minio-ha`            | [`RELEASE.2024-10-13T13-34-11Z`](https://github.com/minio/minio/releases/tag/RELEASE.2024-10-13T13-34-11Z) | No update                    |

> Please refer the individual release notes to get a detailed info on the releases.

## New Features 🎉

### prometheus-adapter

- [[#192](https://github.com/sighupio/fury-kubernetes-monitoring/pull/192)] **Add `v1beta2.custom.metrics.k8s.io` service to prometheus-adapter** to use custom metrics with the Horizontal Pod Autoscaler (HPA).

## Update Guide 🦮

Modules installations and upgrades are now managed by the furyctl tool. Instructions below are left for reference when using the legacy version of furyctl.

### Process

To upgrade this core module from `v3.3.0` to `vTBD`, execute the following:

```bash
kustomize build <your-project-path> | kubectl apply -f - --server-side
```
