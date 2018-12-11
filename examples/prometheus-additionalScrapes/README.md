# Prometheus Additional Scrapes

This example shows how to customize your Prometheus deployment (which you deploy via Prometheus Operator) to add additional scrapes. Example adds 2 scrapes for metrics from external-node-exporter and metrics from etcd.

1. Add you scrapes specifying `job_name`, `interval` and `configuration` for each of them in `prometheus-additional-scrapes.yml` 

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
