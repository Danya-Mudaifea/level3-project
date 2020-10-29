#!/bin/bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo update
helm install prometheus-operator stable/prometheus-operator --namespace monitoring --set grafana.service.type=NodePort --set prometheusOperator.admissionWebhooks.enabled=false --set prometheusOperator.admissionWebhooks.patch.enabled=false --set prometheusOperator.tlsProxy.enabled=false --values toleration.yaml
