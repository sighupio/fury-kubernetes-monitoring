# Prometheus Adding External Labels

This example shows how to add external labels to any time series or alerts for
your Prometheus deployment.

0. Run furyctl to get packages: `furyctl install --dev`

1. Add/modify labels you want to add to your Prometheus deployment, by modifying
   `prometheus-externalLabels.yml` file.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on
   your cluster.
