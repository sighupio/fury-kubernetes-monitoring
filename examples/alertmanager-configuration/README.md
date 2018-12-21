# Alertmanager Configuration

This example shows how to deploy a customized Alertmanager Configuration. It customizes Fury distribution Alertmanager to deploy with no DeadManSwitch and sends all alerts to slack only. This example is meant to illustrate how to attach a new configuration to alertmanager

0. Run furyctl to get packages: `$ furyctl install --dev`

1. You can modify `alertmanager.yaml` file to change slack url with your own ([WebHook integration](https://api.slack.com/incoming-webhooks) needed in your slack) and channel to send the alert to. To see all fields you can modify please refer to [documentation](https://prometheus.io/docs/alerting/configuration/)

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
