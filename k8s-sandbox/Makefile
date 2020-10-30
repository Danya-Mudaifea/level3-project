.PHONY: up down init cluster-up install uninstall logs repos namespaces cluster-down clean provision

up: cluster-up init

down: cluster-down 

cluster-down:
	k3d cluster delete labs

clean: logs
	
cluster-up:
	k3d cluster create labs \
	    -p 80:80@loadbalancer \
	    -p 443:443@loadbalancer \
	    -p 30000-32767:30000-32767@server[0] \
	    -v /etc/machine-id:/etc/machine-id:ro \
	    -v /var/log/journal:/var/log/journal:ro \
	    -v /var/run/docker.sock:/var/run/docker.sock \
	    --k3s-server-arg '--no-deploy=traefik' \
	    --agents 3

init: logs repos namespaces
platform: install-service-mesh install-ingress install-logging install-monitoring install-secrets
deplatform: delete-service-mesh delete-ingress delete-logging delete-monitoring delete-secrets

logs:
	touch output.log
	rm -f output.log
	touch output.log

repos:
	helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	helm repo add hashicorp https://helm.releases.hashicorp.com
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo add elastic https://helm.elastic.co
	helm repo add fluent https://fluent.github.io/helm-charts
	helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
	helm repo update

namespaces:
	kubectl apply -f platform/namespaces

install-corpora:
	kubectl apply -f apps/corpora

delete-corpora:
	kubectl delete -f apps/corpora 2>/dev/null | true

install-cassandra:
	echo "Cassandra: install" | tee -a output.log
	kubectl apply -f https://raw.githubusercontent.com/datastax/cass-operator/v1.4.1/docs/user/cass-operator-manifests-v1.18.yaml

delete-cassandra:
	echo "Cassandra: delete" | tee -a output.log
	kubectl delete -f https://raw.githubusercontent.com/datastax/cass-operator/v1.4.1/docs/user/cass-operator-manifests-v1.18.yaml

install-kafka:
	echo "kafka: install" | tee -a output.log
	kubectl apply -f https://strimzi.io/install/latest?namespace=kafka -n kafka

delete-kafka:
	echo "kafka: delete" | tee -a output.log
	kubectl delete -f https://strimzi.io/install/latest?namespace=kafka -n kafka

install-kafka-default-topic:
	kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml -n kafka

install-cicd:
	echo "cicd: install" | tee -a output.log
	kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
	kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
	kubectl patch svc tekton-dashboard -n tekton-pipelines --type='json' -p '[{"op":"replace", "path":"/spec/type", "value":"NodePort"}]'
	kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/git-clone/0.2/git-clone.yaml

delete-cicd:
	echo "cicd: delete" | tee -a output.log
	kubectl delete -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
	kubectl delete -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml

install-dashboard:
	echo "Dashboard: install" | tee -a output.log
	helm install dashboard kubernetes-dashboard/kubernetes-dashboard -n dashboard -f platform/dashboard/values.yaml
	kubectl patch svc dashboard-kubernetes-dashboard -n dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'

delete-dashboard:
	echo "Dashboard: delete" | tee -a output.log
	helm delete -n dashboard dashboard 2>/dev/null | true

install-service-mesh:
	echo "Service-Mesh: install" | tee -a output.log
	helm install consul hashicorp/consul -n service-mesh -f platform/service-mesh/values.yaml | tee -a output.log

delete-service-mesh:
	echo "Service-Mesh: delete" | tee -a output.log
	helm delete -n service-mesh consul 2>/dev/null | true

install-secrets:
	echo "Secrets: install" | tee -a output.log
	helm install vault hashicorp/vault -n secrets -f platform/secrets/values.yaml | tee -a output.log

delete-secrets:
	echo "Secrets: delete" | tee -a output.log
	helm delete -n secrets vault 2>/dev/null | true

install-ingress:
	echo "Ingress: install" | tee -a output.log
	kubectl apply -n ingress-nginx -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml | tee -a output.log
	kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s

delete-ingress:
	echo "Ingress: delete" | tee -a output.log
	kubectl delete -n ingress -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml | tee -a output.log 2>/dev/null | true

install-monitoring:  
	cd grafana && ./grafana.sh
	kubectl get service -n monitoring
	echo "Access it with : ip/port"
	cd ..

install-logging:
	cd elf && ./elf.sh
	kubectl get service -n logging
	echo "To Access it : ip:port of kibana"
	cd ..

