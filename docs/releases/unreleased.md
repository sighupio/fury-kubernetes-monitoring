<<<<<<< HEAD
# Monitoring Core Module version TBD

SIGHUP team maintains this module updated and tested. That is the main reason why we worked on this new release.
With the Kubernetes 1.20 release, it became the perfect time to start testing this module against this Kubernetes
release.

Continue reading the [Changelog](#changelog) to discover them:

## Changelog

- Modify the alerts that track expiration of cluster certificates to fire within 30/7 days of expiration instead of 7/1 days. (kubeadm-k8s-rules, prometheus-k8s-rules)
- Added missing namespace to thanos submodule components

## Upgrade path

To upgrade to this core module from `v1.11.0`, it should be sufficient to simply apply the `kustomize` project.

```bash
kustomize build | kubectl apply -f -
```
