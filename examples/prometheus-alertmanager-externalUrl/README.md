# Prometheus and Alertmanager external URL

This example shows how to add external URLs to access Prometheus expression
browser and Alertmanager dashboard.

0. Run furyctl to get packages: `furyctl install`

1. Replace `externalUrl` field's value with your desired URLs for Prometheus and
   Alertmanager resources in `prometheus-alertmanager-externalUrl.yml`.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on
   cluster.

4. Check if you can access Prometheus expression browser and Alertmanager
   dashboard from your browser.
