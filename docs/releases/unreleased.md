# Monitoring Core Module version unreleased

SIGHUP team maintains this module updated and tested. This release is a bugfix relase

Continue reading the [Changelog](#changelog) to discover them:

## Changelog

- Fixing thanos modules, missing namespace on components
- Modify the alerts that track expiration of cluster certificates to fire within 30/7 days of expiration instead of 7/1 days. (kubeadm-k8s-rules, prometheus-k8s-rules)
- Add missing namespace field to `configs/bases/default`.

## Upgrade path

Simply upgrade from v1.11.0 No further action is required.

