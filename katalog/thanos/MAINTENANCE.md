# `Thanos` Package Maintenance

To prepare a new release of this package:

1. Get the new upstream release [thanos-io/kube-thanos](https://github.com/thanos-io/kube-thanos/tree/main/examples/all/manifests).

2. Update the images for the new upstream release [`monitoring` images.yaml file fury-distribution-container-image-sync repository](https://github.com/sighupio/fury-distribution-container-image-sync/blob/main/modules/monitoring/images.yml).

```bash
  - name: thanos [Fury Monitoring Module]
    source: quay.io/thanos/thanos
    tag:
      - "v0.20.2"
      - "v0.22.0"
      - "v0.24.0"
      - "v0.30.2"
    destinations:
      - registry.sighup.io/fury/thanos
```

3. Update the `kustomization.yaml` file with the new image.

4. Verify if there are changes for the components in the `base/components` folder and test it with the new release.

## Grafana Dashboards

The included Grafana Dashboards in `thanos/base/components/dashboards/` are taken from here: <https://github.com/thanos-io/thanos/tree/main/examples/dashboards>
