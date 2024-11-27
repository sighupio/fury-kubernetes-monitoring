# `prometheus-operated` Package Maintenance

To prepare a new release of this package:

1. Get the current upstream release and update local files:

> [!IMPORTANT]
> Run the following command from the `katalog` folder.

```bash
export KUBE_PROMETHEUS_RELEASE=v0.14.0
../utils/pull-upstream.sh ${KUBE_PROMETHEUS_RELEASE} prometheus-operated
```

Replace `KUBE_PROMETHEUS_RELEASE` with the current upstream release.

2. Check the differences introduced by pulling the upstream release and add the needed patches in `kustomization.yaml`

3. Remove from `kubernetes-monitoring-rules.yml` the CPUThrottlingHigh alert and move KubeClientCertificateExpiration, KubeSchedulerDown and KubeControllerManagerDown to `configs/kubeadm/rules.yml`.

3. Sync the new image to our registry in the [`monitoring` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/monitoring/images.yml).

4. Update the `kustomization.yaml` file with the new image.

5. Make sure that all the files have the license headers:

```bash
addlicense -c "SIGHUP s.r.l" -v -l bsd -y "2017-present" --check .
```
