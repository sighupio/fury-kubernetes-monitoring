# Monitoring Services with Prometheus ServiceMonitor

This example shows how to define a ServiceMonitor resource to retrieve metrics from an application. As an example we use [prometheus-example-app](https://github.com/brancz/prometheus-example-app) which is a simple app for demonstration purposes. You can deploy it or you can replace it with your application and modify ServiceMonitor in order to monitor your own service. `prometheus-example-app` has following endpoints:

- `/` results in a 200 response code. 
- `/err` results in a 404 response code
- `/metrics` simply returns total count for 200 and 404 response codes.


0. Run furyctl to get packages: `furyctl install`

In `sm.yml` file:

1. `name` and `labels` are set to identify the app that exposes metrics.

2.  `endpoints` specifies where our application exposes metrics. `path` and `port` must match with the one defined in Service. Choose `interval` for scrape frequency as you want.

3. `jobLabel`  is used to retrieve the prometheus job name.

4. `matchNames` must match namespace where your app is deployed and `matchLabels` must match your app's label(same one used in Service selector) in order to target correct application.

In the example's folder:

5. Run `make build` to see what is going to be deployed.

6. Run `make deploy` to deploy app and it service monitor on your cluster.

7. When app's pod status become Ready, make some HTTP GET requests to generate metrics, but first, to access application from localhost run:

`$ kubectl proxy &`

Then you can use curl to make requests:

```
$ curl 127.0.0.1:8080

HTTP/1.1 200 OK
Date: Mon, 04 Feb 2019 15:36:22 GMT
Content-Length: 31
Content-Type: text/plain; charset=utf-8
```

```
$ curl 127.0.0.1:8080/err

HTTP/1.1 404 Not Found
Date: Mon, 04 Feb 2019 15:36:12 GMT
Content-Type: text/plain; charset=utf-8
```

You must see corresponding numbers when you make a HTTP GET request to `metrics` endpoint:

```
$ curl 127.0.0.1:8080/metrics

# HELP http_requests_total Count of all HTTP requests
# TYPE http_requests_total counter
http_requests_total{code="200",method="get"} 1
http_requests_total{code="404",method="get"} 1
# HELP version Version information about this binary
# TYPE version gauge
version{version="v0.1.0"} 0
```

Same results must appear in the Prometheus expression browser, to access it run:

`$ kubectl port-forward svc/prometheus-k8s 9090:9090 --namespace monitoring`

Then in the Prometheus browser, when you query for `http_requests_total` you must get corresponding results:

```
http_requests_total{code="200",endpoint="http",instance="172.17.0.14:8080",job="example-app",method="get",namespace="default",pod="example-app-7f8458f6cf-6fwm2",service="example-app"}	1
http_requests_total{code="404",endpoint="http",instance="172.17.0.14:8080",job="example-app",method="get",namespace="default",pod="example-app-7f8458f6cf-6fwm2",service="example-app"} 1
```
