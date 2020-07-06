#!/usr/bin/env bats

@test "testing kustomize build alertmanager-configuration" {
  cd examples/alertmanager-configuration
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build alertmanager-operated-deployment" {
  cd examples/alertmanager-operated-deployment
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build grafana-add-dashboard" {
  cd examples/grafana-add-dashboard
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build grafana-configuration" {
  cd examples/grafana-configuration
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-additionalScrapes" {
  cd examples/prometheus-additionalScrapes
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-alertmanager-externalUrl" {
  cd examples/prometheus-alertmanager-externalUrl
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-externalLabels" {
  cd examples/prometheus-externalLabels
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-operated-deployment" {
  cd examples/prometheus-operated-deployment
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-operated-nodeSelector" {
  cd examples/prometheus-operated-nodeSelector
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build prometheus-rules" {
  cd examples/prometheus-rules
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
@test "testing kustomize build serviceMonitor" {
  cd examples/serviceMonitor
  furyctl vendor -H
  kustomize build
  rm -rf vendor
}
