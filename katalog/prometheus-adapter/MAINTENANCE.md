# `prometheus-adapter` Package Maintenance

To prepare a new release of this package:

1. Get the current upstream release

```bash
export KUBE_PROMETHEUS_RELEASE=v0.14.0
../../utils/pull-upstream.sh ${KUBE_PROMETHEUS_RELEASE} prometheus-adapter
```

Replace `KUBE_PROMETHEUS_RELEASE` with the current upstream release.

2. Check the differences introduced by pulling the upstream release and add the needed patches in `kustomization.yaml`

3. Update the `prometheus-adapter/apiService.yaml` adding the APIService `v1beta2.custom.metrics.k8s.io` available [here](https://github.com/kubernetes-sigs/prometheus-adapter/blob/master/docs/walkthrough.md#the-registered-api)

4. Sync the new image to our registry in the [`monitoring` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/monitoring/images.yml).

5. Update the `kustomization.yaml` file with the new image.
