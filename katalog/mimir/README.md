# Mimir

<!-- <KFD-DOCS> -->

Mimir is an open source, horizontally scalable, highly available, multi-tenant TSDB for long-term storage for Prometheus.

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize >= `v3.5.3`
- [prometheus-operator from KFD monitoring module][prometheus-operator]
- [grafana from KFD monitoring module][grafana]
- [minio-ha](../minio-ha)

## Image repository

- registry.sighup.io/fury/grafana/mimir
- registry.sighup.io/fury/nginxinc/nginx-unprivileged
- registry.sighup.io/fury/grafana/mimir-continuous-test

## Configuration

Mimir is configured with the distributed approach. We disabled some optional components: Ruler, Override exporter and Alertmanager.
By default, using this package, Prometheus operated is installed and patched to send metrics to Mimir with the remote write capability.

All the time series are ingested in the `fury` tenant. A Grafana datasource is also installed as default for prometheus type metrics to scrape from Mimir instead of Prometheus.

Also, the storage is configured by default to use the minio-ha package from the monitoring module.

## Deployment

You can deploy tempo by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator
[grafana]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/grafana


<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
