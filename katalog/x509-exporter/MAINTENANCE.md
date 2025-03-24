# `x509-exporter` Package Maintenance

To prepare a new release of this package:

1. Get the current upstream release

```bash
mkdir temp && cd temp
helm repo add enix https://charts.enix.io
helm template x509-certificate-exporter enix/x509-certificate-exporter > manifests.yaml
```

2. Check the differences between `manifests.yaml` and the manifests within this repository tree, adjust everything accordingly.

3. Sync the new image to our registry in the [`monitoring` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/monitoring/images.yml).

4. Update each `kustomization.yaml` file with the new image.

5. Remove the temporary directory

```bash
rm -rf temp
```
