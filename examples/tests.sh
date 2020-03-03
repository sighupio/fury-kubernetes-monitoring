#!/usr/bin/env bats

@test "testing kustomize build alertmanager-configuration" {
  cd examples/alertmanager-configuration
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build alertmanager-operated-deployment" {
  cd examples/alertmanager-operated-deployment
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build grafana-add-dashboard" {
  cd examples/grafana-add-dashboard
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build grafana-configuration" {
  cd examples/grafana-configuration
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build grafana-remove-dashboard" {
  cd examples/grafana-remove-dashboard
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-additionalScrapes" {
  cd examples/prometheus-additionalScrapes
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-alertmanager-externalUrl" {
  cd examples/prometheus-alertmanager-externalUrl
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-externalLabels" {
  cd examples/prometheus-externalLabels
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-operated-deployment" {
  cd examples/prometheus-operated-deployment
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-operated-nodeSelector" {
  cd examples/prometheus-operated-nodeSelector
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-rules" {
  cd examples/prometheus-rules
  furyctl install
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build serviceMonitor" {
  cd examples/serviceMonitor
  furyctl install
  kustomize build
  rm -rf vendor
}
