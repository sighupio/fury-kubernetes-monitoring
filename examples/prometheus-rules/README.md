# Prometheus Creating Alert Rules

This example shows how to create alert rules for Prometheus, using
PrometheusRule CRD. Example defines two rules for two different type of event
that can occur.

First rule fires an alert if application MyApp has disappered from Prometheus
target discovery. Second rule fires an alert if application MyApp's failure rate
measured on a time window of 2 minutes was higher than 10% in the last 10
minutes.

Alert rule conditions are defined based on PromQL expressions, with `expr` field
in your rule definitions. To learn more about PromQL please refer to Prometheus
[documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/)

0. Run furyctl to get packages: `furyctl install --dev`

1. Add new rules based on conditions expressed with PromQL, add annotations to
   inform user about alert and specify an interval with `for` field.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on
   your cluster.
