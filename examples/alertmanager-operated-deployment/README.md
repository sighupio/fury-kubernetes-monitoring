# Alertmanager Deployment

This example shows how to deploy a customized Alertmanager. It customizes Fury distribution Alertmanager to deploy version `0.15.2` as 1 replica.

0. Run furyctl to get packages: `furyctl install`

1. You can modify `alertmanager-operated-deployment.yml` file to change replica number and version. To see all fields you can modify please refer to [documentation](https://github.com/coreos/prometheus-operator/blob/main/Documentation/user-guides/alerting.md)

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
