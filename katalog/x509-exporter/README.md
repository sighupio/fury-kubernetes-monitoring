# x509 Exporter

<!-- <KFD-DOCS> -->

This package provides monitoring for certificates.
The original project is: [x509-certificate-exporter](https://github.com/enix/x509-certificate-exporter)


## Requirements

- Kubernetes >= `1.21.0`
- Kustomize = `v3.5.3`
- [prometheus-operator](../prometheus-operator)


## Image repository and tag

* Certificate exporter image: `registry.sighup.io/fury/enix/x509-certificate-exporter:3.2.0`

## Deployment

You can deploy x509 exporter by running the following command:

```shell
kustomize build | kubectl apply -f -
```

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
