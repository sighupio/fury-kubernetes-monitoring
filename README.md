This repo is the documentation for Github Fury Kuberetes Monitoring repo. To be able to access the  fury-kubernetes-monitoring packages you must be a Sighup customer. If you're not a customer yet, contact us at info@sighup.io or http://www.sighup.io for info on how to get access!



# Fury Kubernetes Monitoring
 
This repo contains all components necessary to deploy monitoring tools on top of Kubernetes. We use Prometheus, a very popular open source monitoring and alerting toolkit. You can monitor both cluster itself and applications deployed on cluster via Prometheus. On Kubernetes we use Prometheus Operator to deploy, configure and manage Prometheus instances and to manage Service Monitoring and Alerts. This repo contains a package to deploy Prometheus Operator and other packages to deploy Prometheus instances and exporters to be consumed by Prometheus.



## Requirements

- Kubernetes cluster v1.3.x or v1.4.x with alpha APIs enabled (qui magari un link a documentazione)
- [Furyctl](documentation_link) package manager to install Fury packages
- [Kustomize v1](https://github.com/kubernetes-sigs/kustomize) 



## Furyctl

In order to get Fury packages you should first install [Furyctl](documentation_link)
Furyctl is package manager for Fury distribution. It’s simple to use and reads a single Furyfile which contains packages you want to get. To learn how to install and use Furyctl please see the link above


## Kustomize

Kustomize lets you create customized Kubernetes resources based on a Kubernetes YAML resource file, leaving the original YAML untouched and usable as is. For more detail on Kustomize please follow the under requirements section.  

Once you have kustomize, modify kustomization.yaml you find inside the package to meet your customization needs or leave it as it is if defaults are ok for you. Then you can run kustomize in the root of the package folder:

`$ kustomize build | kubectl apply -f -`




## Prometheus Operator

Operators are application specific controllers for complex stateful applications. They are used to have more Kubernetes-native control over applications. Prometheus Operator makes it easy to deploy and manage Prometheus instances. But also provides easy monitoring definitions for Kubernetes services.  

Thanks to Prometheus Operator you don't have to learn Prometheus specific configuration language to monitor your services. Service targeting is achieved via Kubernetes Labels and monitoring target configurations are automatically generated based on Kubernetes label queries.

/* da ri-scrivere
Operator ensures at all times that for each Prometheus resource in the cluster a set of Prometheus servers with the desired configuration are running. 
Each Prometheus instance is paired with a respective configuration that specifies which monitoring targets to scrape for metrics and with which parameters.

The Operator configures the Prometheus instance to monitor all services covered by included ServiceMonitors and keeps this configuration synchronized with any changes happening in the cluster.
perator encapsulates a large part of the Prometheus domain knowledge and only surfaces aspects meaningful to the monitoring system's end user. 
*/


### Prometheus Operator CRDs:

Spiega a cosa servono 

The Operator acts on the following custom resource definitions (CRDs):

- `Prometheus`, which defines a desired Prometheus deployment. The Operator ensures at all times that a deployment matching the resource definition is running.

- `ServiceMonitor`, which declaratively specifies how groups of services should be monitored. The Operator automatically generates Prometheus scrape configuration based on the definition.

- `PrometheusRule`, which defines a desired Prometheus rule file, which can be loaded by a Prometheus instance containing Prometheus alerting and recording rules.

- `Alertmanager`, which defines a desired Alertmanager deployment. The Operator ensures at all times that a deployment matching the resource definition is running.


### Service Monitoring

Our Prometheus Operator package deploys Prometheus to monitor both cluster itself and applications deployed on cluster.

NEED EXAMPLE HERE


### Alerts


### Accessing Prometheus UI

After deploying a Prometheus Instance we can access Prometehus UI by exposed Kubernetes Service on port 9090:

`kubectl port-forward svc/prometheus-k8s 9090:9090`



## Monitoring Packages 

To deploy Prometheus Operator you need 

- [prometheus-operator]() package. You can click on link to get more information about our prometheus operator deployment.

One you have Prometheus Operator up and running you can deploy following components :

- [alertmanager-operated]() :
- [gcp-sm]() :
- [grafana]() :
- [kubeadm-sm]() :
- [kube-state-metrics]() : 
- [node-exporter]() :
- [prometheus-operated]() : Prometheus instances


You can click on each package to learn how to deploy and use each of them.


## License
For license details please see [LICENSE](license_link) 

