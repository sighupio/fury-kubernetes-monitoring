# Monitoring Services with Prometheus ServiceMonitor

This example shows how to define a ServiceMonitor resources to retrieve metrics from an application.

0. Run furyctl to get packages: `furyctl install --dev`

In `sm.yml` file:

1. Set labels to identify your app that exposes metrics.

2. Specify endpoints where your application exposes metrics. There can be more then 1 endpoint. Specify `path`, `port` and `scheme` of endpoints and define `interval` for scrape frequency you desire.

3. Set `matchNames` and `matchLabels` with your app's namespace and label in order to target correct services.

In the example's folder:

4. Run `make build` to see output of kustomize with your modifications.

5. Once you're satisfied with generated output run `make deploy` to deploy it on your cluster.
