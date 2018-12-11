# Prometheus Adding External Labels Example

This example shows how to add external labels to any time series or alerts when Prometheus communicating with external systems (federation, remote storage, Alertmanager).

1. Add/modify labels you want to add to your Prometheus deployment, by modifying `prometheus-externalLabels.yml` file. 

2. run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it to your cluster.
