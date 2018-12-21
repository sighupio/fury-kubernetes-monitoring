# Prometheus Operated NodeSelector

This example shows how to customize your Prometheus deployment (which you deploy via Prometheus Operator) changing the node selector to deploy Prometheus only on nodes with a particular labels. To see full list of fields that you can modify please refer to Prometheus CRD manifest.

0. Run furyctl to get packages: `$ furyctl install --dev`

In `prometheus-operated-nodeSelector.yml`

1. Modify `nodeSelector` field selecting the desired labels.

In the example's directory:

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
