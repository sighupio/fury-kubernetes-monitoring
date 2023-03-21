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

Fury distribution Thanos have 2 different possible setups deployed with the following configuration:

```bash
thanos-minio 
    single
    triple
thanos-s3 
    single
    triple
```

Depending on the number of replicas you choose in the Prometheus section, you can choose if use thanos patched in the query component:

- [target-single](base/thanos-single/config/store-sd.yaml)
- [target-triple](base/thanos-triple/config/store-sd.yaml)

With [MinIO](thanos-minio/base/minio-ha/README.md) you have an all-in-one solution with a storage, instead with the module [s3](https://thanos.io/tip/thanos/storage.md/#s3) you can manage the storage on top an aws s3 bucket. Please take a look at how modify the [`objectstore.yml`](thanos-s3/base/config/objectstore.yaml) like in follow to patch you credentials to the module

```yml
# description: config + credentials for access to object storage
secretGenerator:
- name: thanos-objstore-secret
  namespace: monitoring
  files:
    - objstore.yml=objstore.yml
```

If you want to us the kind of Object Storage like `minIO` or `s3` you can import the `s3` module and override the entire configuration, just please take a look at how to the changes [Thanos storage list](https://thanos.io/tip/thanos/storage.md)

## Deployment

Before deploying this, please take a look at how to modify Thanos.
You can deploy Thanos by running the following command:

```shell
kustomize build | kubectl apply -f - --server-side --force-conflicts
```

### Accessing Thanos frontend UI

You can access to Thanos dashboard by port-forwarding on port 9093:

```shell
kubectl port-forward svc/thanos-query-frontend 9090:9090 --namespace monitoring
```

Now you can go to [http://127.0.0.1:9090](http://127.0.0.1:9090) on your browser
to manage the query frontend.

There is no ingress defined by default, you can add something like this:

```yaml
apiVersion: extensions/v1
kind: Ingress
metadata:
    name: thanos
    namespace: monitoring
    annotations:
        forecastle.stakater.com/expose: "true"
        forecastle.stakater.com/icon: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQIi0w9WqMmkCcjgC03kxOFhkdeDuV2UIgKo9xfiugGSjRLxstEw"
        kubernetes.io/ingress.class: internal
        nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
        nginx.ingress.kubernetes.io/ssl-redirect: "true"
    labels:
        app: thanos-query-frontend
spec:
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