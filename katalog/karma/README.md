# Karma

<!-- <KFD-DOCS> -->

Karma is a UI for Alertmanager, useful for browsing alerts based on labels and managing silences.
It can also aggregate alerts from multiple Alertmanager instances.

*Source:* [prymitive/karma][k-gh]

## Requirements

- Kubernetes >= `1.29.0`
- Kustomize = `5.6.0`
- [prometheus-operator](../prometheus-operator)
- [prometheus-operated](../prometheus-operated)
- [alertmanager-operated](../alertmanager-operated)

## Image repository and tag

- Karma image: `registry.sighup.io/fury/prymitive/karma/karma:v0.113`
- Karma repository: [Karma on GitHub][k-gh]

## Configuration

Fury distribution Karma is deployed with the following
configuration:

- Alertmanager URI: `http://alertmanager-main.monitoring.svc.cluster.local:9093`
- Polling interval: `1m`

All configuration options can be found [here](https://github.com/prymitive/karma/blob/v0.113/docs/CONFIGURATION.md)

## Deployment

You can deploy karma by running the following command:

```shell
kustomize build katalog/karma | kubectl apply -f -
```

<!-- Links -->

[k-gh]: https://github.com/prymitive/karma

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
