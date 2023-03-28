# Thanos

<!-- <KFD-DOCS> -->

Thanos is an opensource Prometheus setup that allows having 2 important features:

1. high availability on Prometheus (setting more Prometheus replicas)
2. long term storage capacity relying on an external object storage

## Image repository and tag

- Thanos components versions: `v0.30.2`
- Thanos components image: `registry.sighup.io/fury/thanos/thanos:v0.30.2`

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize = `v3.5.3`
- [prometheus-operator](../prometheus-operator)
- [prometheus-operated](../prometheus-operated)

## Setup in Fury Module

KFD Thanos package has 2 different possible deployment setups `thanos-minio` using a MinIO instance for storage and `thanos-s3` using an S3 bucket as storage. Each one can be configured to proxy a single Prometheus instance or 3 Prometheus instances simultaneously:

```bash
thanos-minio 
    single
    triple
thanos-s3 
    single
    triple
```

Depending on the number of replicas you choose in the Prometheus section, you must use the corresponding Thanos configuration for the Query component:

- [target-single](base/thanos-single/config/store-sd.yaml)
- [target-triple](base/thanos-triple/config/store-sd.yaml)

With [MinIO](thanos-minio/base/minio-ha/README.md) you have an all-in-one solution including storage, instead with the module [s3](https://thanos.io/tip/thanos/storage.md/#s3) variant, you can manage the storage on top a bucket. Please take a look at how to modify the [`objectstore.yml`](thanos-s3/base/config/objectstore.yaml) to patch your credentials in the correct way.

```yml
# description: config + credentials for access to object storage
secretGenerator:
- name: thanos-objstore-secret
  namespace: monitoring
  files:
    - objstore.yml=objstore.yml
```

If you want to use another kind of Object Storage than `minIO` or `s3` you can import the `s3` module and override the entire configuration, take a look at how to do the changes in the [Thanos storage lis page](https://thanos.io/tip/thanos/storage.md)

## Deployment

Before deploying this, please take a look at how to modify Thanos.
You can deploy Thanos by running the following command:

```shell
kustomize build | kubectl apply -f - --server-side
```

### Accessing Thanos frontend UI

You can access the Thanos dashboard by port-forwarding the service `thanos-query-frontend` with:

```shell
kubectl port-forward svc/thanos-query-frontend 9090:9090 --namespace monitoring
```

Now you can go to [http://127.0.0.1:9090](http://127.0.0.1:9090) on your browser
to manage the query frontend.

Even though the port forward is useful for a quick test. It is better to create an ingress for the Thanos Query Frontend.
There is no ingress defined by default with the package, you can add one with something like this:

```yaml
apiVersion: extensions/v1
kind: Ingress
metadata:
    name: thanos
    namespace: monitoring
    annotations:
        forecastle.stakater.com/expose: "true"
        forecastle.stakater.com/icon: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQIi0w9WqMmkCcjgC03kxOFhkdeDuV2UIgKo9xfiugGSjRLxstEw"
    labels:
        app: thanos-query-frontend
spec:
    ingressClassName: internal  # if you are not using dual-nginx, adjust accordingly
    rules:
        - host: thanos.example.com
          http:
            paths:
            - path: "/"
                pathType: Prefix
                backend:
                  service:
                    name: thanos-query-frontend
                    port:
                      name: http
```

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)