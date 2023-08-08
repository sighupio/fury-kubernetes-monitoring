# `grafana` Package Maintenance

To prepare a new release of this package:

1. Get the current upstream release

```bash
export KUBE_PROMETHEUS_RELEASE=v0.11.0
../../utils/pull-upstream.sh ${KUBE_PROMETHEUS_RELEASE} grafana
```

Replace `KUBE_PROMETHEUS_RELEASE` with the current upstream release.

2. Check the differences introduced by pulling the upstream release and add the needed patches in `kustomization.yaml`

3. Sync the new image to our registry in the [`monitoring` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/monitoring/images.yml).

4. Update the `kustomization.yaml` file with the new image.

## Customizations

- We've changed the json file inside grafana-dashboardSources, dropping the folder name and enbling the option to use subfolders.
- Added `FOLDER_ANNOTATION` environment variable to the dashboards sidecar.
- Added custom grafana dashboard (`fury-cluster-overview.json`), which shows an overview of the status of the resources present in the cluster.
