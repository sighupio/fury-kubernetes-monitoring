# MinIO HA

<!-- <KFD-DOCS> -->

MinIO is a popular distributed object storage system that allows organizations to deploy highly available
and scalable storage infrastructure.
In order to achieve high availability (HA) for MinIO, a cluster of multiple MinIO nodes must be deployed,
with each node having access to its own set of disks.

## Requirements

- Kubernetes >= `1.23.0`
- Kustomize >= `v3.5.3`
- [prometheus-operator from KFD monitoring module][prometheus-operator]\

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `minio` on prometheus

## Image repository and tag

* MinIO image: `minio/minio`
* MinIO repo: [MinIO on Github][minio-gh]

## Configuration

MinIO HA is deployed in the following configuration:

- Three Pod MinIO statefulset with 2 disks per Pod
- Custom init Job to initialize buckets (`loki` and `errors`)  and default retention (7 days on `errors` bucket)

## Deployment

You can deploy minio-ha by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator
[minio-gh]: https://github.com/minio/minio

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)