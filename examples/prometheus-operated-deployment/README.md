# Prometheus Operated Deployment

This example shows how to customize your Prometheus deployment (which you deploy via Prometheus Operator) changing default retention policy and adding a PersistentVolumeClaim for 150Gi of storage. To see full list of fields that you can modify please refer to Prometheus CRD manifest.

0. Run furyctl to get packages: `$ furyctl install --dev`

In `prometheus-operated-deployment.yml`

1. Modify `retention` field for time duration you want.

2. Modify `VolumeClaimTemplate` field to claim a storage resource of your desired `size` and `accessMode`.

In the example's directory:

3. Run `make build` to see output of kustomize with your modifications.

4. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
