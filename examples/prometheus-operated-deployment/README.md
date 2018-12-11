# Prometheus Operated Deployment

This example shows how to customize your Prometheus deployment (which you deploy via Prometheus Operator) changing default retention policy and adding a PersistentVolumeClaim for 150Gi storage. To see full list of fields that you can modify please refer to Prometheus CRD manifest.

1. Modify `retention` field for your desired time duration.

2. Modify `VolumeClaimTemplate` fields to claim a storage resource of your desired `size` and `accessMode`.

3. run `make build` to see output of kustomize with your modifications.

4.  Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
