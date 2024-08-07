# Mimir - maintenance

To maintain the Mimir package, you should follow this steps.

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm search repo grafana/mimir-distributed # get the latest chart version
helm pull grafana/mimir-distributed --version 5.2.1 --untar --untardir /tmp # this command will download the chart in /tmp/mimir-distributed
```

Run the following command:

```bash
helm template mimir-distributed /tmp/mimir-distributed -n monitoring --values MAINTENANCE.values.yaml > mimir-distributed-built.yaml
```

With the `mimir-distributed-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

Move the dashboards in place:

```bash
cp /tmp/mimir-distributed/mixins/dashboards/*.json dashboards
```

Move the prometheus rules in place:

```bash
helm template mimir-distributed /tmp/mimir-distributed \
  --set metaMonitoring.prometheusRule.enabled=true \
  --set metaMonitoring.prometheusRule.mimirAlerts=true \
  --set metaMonitoring.prometheusRule.mimirRules=true \
  -s templates/metamonitoring/mixin-alerts.yaml \
  -s templates/metamonitoring/prometheusrule.yaml \
  -s templates/metamonitoring/recording-rules.yaml \
  -n monitoring --values MAINTENANCE.values.yaml > rules.yaml
```

Note: the `config/mimir.yaml` file is not generated via the Helm chart.

What was customized:

- Disabled mimir alertmanager
- Disabled in-tree minio, configured to use our own minio-ha deployment
- Disabled overrides exporter
- Disabled ruler
- Disabled rollout operator
- Grafana dashboards have been added manually instead of using the autogenerated configmaps from the chart
- PrometheusRules have been moved on a dedicated file
- Removed Pod Security Policy
- Added `compactor_blocks_retention_period: 720h` on mimir config
- Added `max_global_series_per_user: 0` to mimir config
