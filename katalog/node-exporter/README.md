# Node Exporter

This package provides monitoring for hardware and OS metrics exposed by \*NIX
kernels provided by node-exporter service. You can see a list of collectors
enabled by default from the project's
[repository](https://github.com/prometheus/node_exporter#collectors)


## Requirements

- Kubernetes >= `1.18.0`
- Kustomize = `v3.0.x`
- [prometheus-operator](../prometheus-operator)


## Image repository and tag

* node-exporter image: `quay.io/prometheus/node-exporter:v1.2.2`
* node-exporter repository: [https://github.com/prometheus/node_exporter](https://github.com/prometheus/node_exporter)


## Configuration

Fury distribution node-exporter is deployed with the following configuration:
- Ignore filesystem mount points starting with `dev|proc|sys|var/lib/docker` (local to the container file system)
- Ignore filesystem types `autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs`
- Resource limits are `250m` for CPU and `180Mi` for memory
- Listens on port `9100`


## Deployment

You can deploy node-exporter by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```


## License

For license details please see [LICENSE](../../LICENSE)
