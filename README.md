This repo is the documentation for Github Fury Kuberetes Monitoring repo. To be able to access the  fury-kubernetes-monitoring packages you must be a Sighup customer. If you're not a customer yet, contact us at info@sighup.io or http://www.sighup.io for info on how to get access!



# Fury Kubernetes Monitoring
 
This repo contains all components necessary to deploy monitoring tools on top of Kubernetes. We use Prometheus, a very popular open source monitoring and alerting toolkit for cloud-native applications. You can monitor both cluster itself and applications deployed on cluster via Prometheus. AlertManager which makes part of Prometheus stack, handles alerts sent by Prometheus server and let you manage alerts flexibly and route them receiver integrations such as email, Slack or PagerDuty. Thanks to the components in the Fury Kubernetes Monitoring stack, you're going to have full control on your cluster. On Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus instances and to manage Service Monitoring and Alerts. This repo contains a package to deploy Prometheus Operator and other packages to deploy Prometheus instances and exporters to be consumed by Prometheus. Packages with `-operated` postfix are packages which are deployed via Operator' therefore  you need Prometheus operator up and running to be able to deploy them.  


## Requirements

All packages in this repository have following dependencies, for package specific dependencies please visit the single package's documentation:

- [Kubernetes](kubernetes.io) >= `v1.10`
- [Furyctl](documentation_link) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) 



### Furyctl

In order to get Fury packages you should first install [Furyctl](documentation_link). Furyctl is package manager for Fury distribution. It’s simple to use and reads a single Furyfile which contains packages you want to get. To learn how to install and use Furyctl please see the link above.


### Kustomize

Kustomize lets you create customized Kubernetes resources based on a Kubernetes YAML resource file, leaving the original YAML untouched and usable as is. To learn how to install Kustomize . Once you have kustomize, modify kustomization.yaml you find inside the package to meet your customization needs or leave it as it is if defaults are ok for you. Then you can run kustomize in the root of the package you want to deploy:

`$ kustomize build | kubectl apply -f -`

For further details please visit project's [repo] (https://github.com/kubernetes-sigs/kustomize)

##  Monitoring Packages 

Following packages are included in Fury Kubernetes Monitoring katalog. All resources in these repositories are going to be deployed in `monitoring` namespace in your Kubernetes cluster.

- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator/README.md) It manages full stack of monitoring.
- [prometheus-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operated/README.md) : Prometheus instance to deploy with Prometheus Operator
- [alertmanager-operated](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/alertmanager-operated/README.md) : Prometheus Alert Manager to handle alerts sent by client applications such as the Prometheus server
- [grafana]() : Grafana lets you query and visualize metrics collected by Prometheus
- [gcp-sm]() : Service Monitor to collect metrics from GoogleCloud Kubernetes cluster kubelet components(?)
- [kubeadm-sm]() : Service Monitor to collect metrics exposed by CoreDNS server on your Kubernetes cluster
- [kube-state-metrics]() : Exporter for metrics about the state of Kubernetes objects such as Deployments, Nodes and Pods  
- [node-exporter]() : Exporter for hardware and OS metrics exposed by \*NIX kernels


You can click on each package to learn how to deploy and use each of them.


### Prometheus Operator

To be able to deploy monitoring components, first you should deploy Prometheus Operator. As explained above, it manages Prometheus instances, service monitoring and alert management. To learn how to deploy Prometheus Operator please follow the documentation of [prometheus-operator]() package.

To learn more about Prometheus and how to deploy it's instances follow [prometheus-operated]() package's documentation.


## License
For license details please see [LICENSE](license_link) 

