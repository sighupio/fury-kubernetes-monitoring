# MinIO HA - maintenance

To maintain the MinIO package, you should follow this steps.

Download the latest tgz from [Main Minio repository releases][github-releases].

Extract to a folder of your choice, for example: `/tmp/minio`.
Run the following command:

```bash
helm template minio-logging /tmp/minio/helm/minio --values MAINTENANCE.values.yaml -n logging > minio-built.yaml
```

What was customized (what differs from the helm template command):

- Config has been moved from the template output and generated via kustomize
- Add a custom init job to create buckets and add 7 day retention
- Add `preferredDuringSchedulingIgnoredDuringExecution` on minio pods

[github-releases]: https://github.com/minio/minio/releases

## Prometheus Alerts

The included prometheus alerts for MinIO are taken from here: <https://awesome-prometheus-alerts.grep.to/rules.html#minio-1>

References:

- <https://min.io/docs/minio/kubernetes/upstream/operations/monitoring/metrics-and-alerts.html>
- <https://min.io/docs/minio/linux/operations/monitoring/collect-minio-metrics-using-prometheus.html#configure-an-alert-rule-using-minio-metrics>
