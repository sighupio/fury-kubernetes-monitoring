# Grafana Removing Dashboard

This example shows how to remove a dashboard from Grafana. Kustomization file supports customizing resources via JSON patches. Example removes dashboard mounted as 4. volume to Grafana. In Fury distribution Grafana Deployment it would be Gluster dashboard. Dashboards are numbered for their mount order, index starting from 0.

0. Run furyctl to get packages: `furyctl install`

1. Replace volumeMount number with the number of dashboard you want to remove.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on your cluster.
