# Prometheus Additional Scrapes

This example shows how to customize your Prometheus deployment (deployed via
Prometheus Operator CRD) to add additional scrapes. This example adds 2 scrape
configurations: one for metrics from external-node-exporter and other for
metrics from etcd.

0. Run furyctl to get packages: `furyctl install --dev`

1. To learn how to write scrape config like in
   `prometheus-additional-scrapes.yml` file please refer to Prometheus
   [documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#%3Cscrape_config%3E)

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on
   cluster.
