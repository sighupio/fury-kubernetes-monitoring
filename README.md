This repo is the documentation for Github Fury Kubernetes Monitoring repo. To be able to access the  fury-kubernetes-monitoring packages you must be a Sighup customer. If you're not a customer yet, contact us at info@sighup.io or http://www.sighup.io for info on how to get access!



# Fury Kubernetes Monitoring
 
This repo contains all components necessary to deploy monitoring tools on top of Kubernetes. We use Prometheus, a very popular open source monitoring and alerting toolkit for cloud-native applications. You can monitor both cluster itself and applications deployed on cluster via Prometheus. AlertManager which makes part of Prometheus stack, handles alerts sent by Prometheus server and let you manage alerts flexibly and route them receiver integrations such as email, Slack or PagerDuty. Thanks to the components in the Fury Kubernetes Monitoring stack, you're going to have full control on your cluster. On Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus instances and to manage Service Monitoring and Alerts. This repo contains a package to deploy Prometheus Operator and other packages to deploy Prometheus instances and exporters to be consumed by Prometheus. Packages with `-operated` postfix are packages which are deployed via Operator' therefore  you need Prometheus operator up and running to be able to deploy them.  


## Requirements

All packages in this repository have following dependencies, for package specific dependencies please visit the single package's documentation:

- [Kubernetes](kubernetes.io) >= `v1.10`
- [Furyctl](documentation_link) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= v1 



### Furyctl

In order to get Fury packages you should first install [Furyctl](documentation_link). Furyctl is package manager for Fury distribution. It’s simple to use and reads a single Furyfile which contains a list of packages you want to get. To learn how to install and use Furyctl please see the link above.


### Kustomize

[Kustomize]() lets you create customized Kubernetes resources based on a Kubernetes YAML resource file, leaving the original YAML untouched and usable as is. You're going to use kustomize to patch our distribution based on your needs (for production, for staging etc), without modifying original resource files.


#### Customization of packages with overlays

To generate variants of a configuration for different use cases (like development, staging or production) you need to use overlays of Kustomize. An overlay is just another kustomization, refering to the base and to the patches to apply on that base.

**overlay = kustomization file + patches + more resources**

We recommend following directory structure for your resource files:

```
kubernetes
├── base
│   └── kustomization.yaml
├── production
│   ├── a_resource.yml
│   ├── kustomization.yaml
│   └── a_patch.yml
└── staging
    ├── a_resource.yml
    ├── kustomization.yaml
    └── a_patch.yml
```

Your `base` dir must include all bases and patches common to your different environments. It can also include other resources you want to add. Then in your overlaying directories you can apply patches to only differing bases.

Your `base/kustomization.yaml` file will have following content:

```yaml
bases:
  - /path/to/vendor/bases/monitoring/alertmanager-operated
  - /path/to/vendor/bases/monitoring/prometheus-operated
  - /path/to/vendor/bases/monitoring/node_exporter
  // ...

patches:
  - ./prometheus-patch
  - ./alertmanager-patch
  //..

resources:
  - /path/to/resource/file
  // ..
```

Paths can be relative to where your kustomization file is located. Fury distribution packages will be your bases to refer. Remember that `furyctl` downloads them under `vendor` directory. Ofcourse you can structure your directory structure differently, as long as you use correct paths for your directories and files, kustomize will work.


#### Examples

To see examples on how to customize Fury distribution with kustomize please go to [examples folder](https://github.com/sighup-io/fury-kubernetes-monitoring/tree/master/examples)


##  Monitoring Packages 

Following packages are included in Fury Kubernetes Monitoring katalog. All resources in these repositories are going to be deployed in `monitoring` namespace in your Kubernetes cluster.

- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator) : Operator to deploy and manages Prometheus and related resources.
- [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operated) : Prometheus instance to deploy with Prometheus Operator
- [alertmanager-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/alertmanager-operated) : Prometheus Alert Manager to handle alerts sent by client applications such as the Prometheus server
- [grafana](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/grafana) : Grafana lets you query and visualize metrics collected by Prometheus
- [gcp-sm](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/gcp-sm) : Service Monitor to collect metrics from GoogleCloud Kubernetes cluster kubelet components(?)
- [kubeadm-sm](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/kubeadm-sm) : Service Monitor to collect metrics exposed by CoreDNS server on your Kubernetes cluster
- [kube-state-metrics](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/kube-state-metrics) : Exporter for metrics about the state of Kubernetes objects such as Deployments, Nodes and Pod
- [node-exporter](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/node-exporter) : Exporter for hardware and OS metrics exposed by \*NIX kernels


You can click on each package to see its documentation.


### Prometheus Operator

To be able to deploy monitoring components, first you should deploy Prometheus Operator. As explained above, it manages Prometheus instances, service monitoring and alert management. To learn how to deploy Prometheus Operator please follow the documentation of [prometheus-operator]() package.

To learn more about Prometheus and how to deploy it's instances follow [prometheus-operated]() package's documentation.


## License
For license details please see [LICENSE](license_link) 

