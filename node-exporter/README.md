This repo is the documentation for Github Fury Kubernetes Monitoring repo. To be able to access the  fury-kubernetes-monitoring packages you must be a Sighup customer. If you're not a customer yet, contact us at info@sighup.io or http://www.sighup.io for info on how to get access!

# Node Exporter Katalog

This package provides monitoring for hardware and OS metrics exposed by \*NIX kernels provided by node-exporter service. You can see list of collectors enabled by default from project's [repository](https://github.com/prometheus/node_exporter#collectors)


## Requirements

- Kubernetes >= 1.10.0
- Kustomize >= v1
- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/prometheus-operator)
- [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/prometheus-operated)


## Image repository and tag

node-exporter image : `quay.io/prometheus/node-exporter:v0.16.0`

node-exporter repository : [https://github.com/prometheus/node_exporter]()


## Configuration

Fury distribution node-exporter is deployed with following configuration:
- As mentioned above a serie of collectors are enabled by default. Fury distribution ignores following metrics:
  * filesystem mount points that start with `dev|proc|sys|var/lib/docker`
  * filesystem fs types `autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs`
- Resource limits are `102m` for CPU and `180Mi` for memory
- Listens on port `9100`


## Deployment

You can deploy node-exporter by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`


## License

For license details please see [LICENSE](license_link) 
