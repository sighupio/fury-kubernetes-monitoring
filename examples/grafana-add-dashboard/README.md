# Grafana Adding Dashboard

This example shows how to add new dashboards to your Grafana instance. A
dashboards is represented by a JSON object and mounted as a ConfigMap to Grafana
Deployment, in `/grafana-dashboard-definitions/folder_name/` path. JSON file
contains dashboard properties, metadata from panels, template variables, panel
queries etc. A dashboard has one or more panels which are building blocks of a
dashboard. Each data query visualization is a panel. To learn more about Grafana
dashboard JSON please see the Grafana
[documentation](http://docs.grafana.org/reference/dashboard/).

0. Run furyctl to get packages: `furyctl install --dev`

1. Configure dashboard details, add or remove panels from dashboard by modifying
   `sighup-sample-dashboard.json` file.

2. `kustomization.yml` creates a ConfigMap from `sighup-sample-dashboard.json`
   file

3. `add-dashboard.yml` patches Grafana Deployment to mount ConfigMap to Grafana
   Deployment.

3. Run `make build` to see output of kustomize with your modifications.

4. Once you're satisfied with generated output run `make deploy` to deploy it on
   your cluster.
