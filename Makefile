all: up run 

make build: init logging monitoring deploy-website  


secret-docker:
	docker login 		
	kubectl create secret generic danyacreds \
 	--from-file=.dockerconfigjson=/home/ubuntu/.docker/config.json \
 	--type=kubernetes.io/dockerconfigjson -n test

secret-docker-prod:
	docker login            
	kubectl create secret generic danyacreds \
        --from-file=.dockerconfigjson=/home/ubuntu/.docker/config.json \
        --type=kubernetes.io/dockerconfigjson -n prod

up:
	cd k8s-sandbox && make up && make install-cicd && make install-ingress && cd .. && kubectl create namespace test && kubectl create namespace prod && make secret-docker

make down: 
	cd k8s-sandbox && make down && make delete-cicd && make delete-ingress && cd ..
logging:
	cd k8s-sandbox && make install-logging && cd ..
monitoring:
	cd k8s-sandbox && make install-monitoring && cd ..
deploy-website-test:
	#kubectl create namespace test
	kubectl apply -f ./front-end/deploy/front-end-dep.yaml -n test
	kubectl apply -f ./front-end/deploy/front-end-svc.yaml -n test
	kubectl apply -f ./front-end/deploy/ingress.yaml -n test
	kubectl apply -f ./carts/deploy/carts-db-dep.yaml -n test
	kubectl apply -f ./carts/deploy/carts-db-svc.yaml -n test
	kubectl apply -f ./carts/deploy/carts-dep.yaml -n test
	kubectl apply -f ./carts/deploy/carts-svc.yml -n test
	kubectl apply -f ./catalogue/deploy/catalogue-db-dep.yaml -n test
	kubectl apply -f ./catalogue/deploy/catalogue-db-svc.yaml -n test
	kubectl apply -f ./catalogue/deploy/catalogue-dep.yaml -n test
	kubectl apply -f ./catalogue/deploy/catalogue-svc.yaml -n test
	kubectl apply -f ./orders/deploy/orders-db-dep.yaml -n test
	kubectl apply -f ./orders/deploy/orders-db-svc.yaml -n test
	kubectl apply -f ./orders/deploy/orders-dep.yaml -n test
	kubectl apply -f ./orders/deploy/orders-svc.yaml -n test
	kubectl apply -f ./payment/deploy/payment-dep.yaml -n test
	kubectl apply -f ./payment/deploy/payment-svc.yaml -n test
	kubectl apply -f ./shipping/deploy/shipping-dep.yaml -n test
	kubectl apply -f ./shipping/deploy/shipping-svc.yaml -n test
	kubectl apply -f ./user/deploy/user-db-dep.yaml -n test
	kubectl apply -f ./user/deploy/user-db-svc.yaml -n test
	kubectl apply -f ./user/deploy/user-dep.yaml -n test
	kubectl apply -f ./user/deploy/user-svc.yaml -n test

run:
	make resource && make build_deploy && make pipeline && make pipelinerun && make pods-status && make testing 


resource:
	kubectl create -f ./tekton/role.yaml -n test
	kubectl create -f ./tekton/role-binding.yaml -n test
	kubectl create -f ./tekton/sa-front-end.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-front-end.yaml -n test	
	kubectl create -f ./tekton/PipelineResource/PipelineResource-catalogue.yaml -n test	
	kubectl create -f ./tekton/PipelineResource/PipelineResource-queue-master.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-orders.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-shipping.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-user.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-payment.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-carts.yaml -n test	
	kubectl create -f ./tekton/PipelineResource/PipelineResource-load-test.yaml -n test
	kubectl create -f ./tekton/PipelineResource/PipelineResource-e2e-js-test.yaml -n  test

build_deploy:
	kubectl create -f ./tekton/tasks/build-push-task.yaml -n test
	kubectl create -f ./tekton/tasks/deploy-task.yaml -n test
	kubectl create -f ./tekton/tasks/deploy-task-prod.yaml -n test

pipeline:
	kubectl create -f ./tekton/pipeline/pipeline-front-end.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-catalogue.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-queue-master.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-rabbitmq.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-orders.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-shipping.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-user.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-payment.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-carts.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-load-test.yaml -n test

pipelinerun:
	kubectl create -f ./tekton/pipelinerun/PipelineRun-front-end.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-catalogue.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-queue-master.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-rabbitmq.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-orders.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-shipping.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-user.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-payment.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-carts.yaml -n test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-load-test.yaml -n test

status: 
	kubectl wait --for=condition=available --timeout=1000s --all deployments -n test
testing:
	kubectl create -f ./tekton/tasks/run-e2e.yaml -n test
	kubectl create -f ./tekton/pipeline/pipeline-e2e-js-test.yaml -n  test
	kubectl create -f ./tekton/pipelinerun/PipelineRun-e2e-js-test.yaml -n  test


pipelinerun-delete:
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-front-end.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-catalogue.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-queue-master.yaml -n test	
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-rabbitmq.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-orders.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-shipping.yaml -n test	
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-user.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-payment.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-carts.yaml -n test
	kubectl delete -f ./tekton/pipelinerun/PipelineRun-load-test.yaml -n test
pipeline-delete:
	kubectl delete -f ./tekton/pipeline/pipeline-front-end.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-catalogue.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-queue-master.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-rabbitmq.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-orders.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-shipping.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-user.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-payment.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-carts.yaml -n test
	kubectl delete -f ./tekton/pipeline/pipeline-load-test.yaml -n test

delete-resource:
	#kubectl delete namespace test
	kubectl delete -f ./tekton/role.yaml -n test
	kubectl delete -f ./tekton/role-binding.yaml -n test
	kubectl delete -f ./tekton/sa-front-end.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-front-end.yaml -n test	
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-catalogue.yaml -n test	
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-queue-master.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-orders.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-shipping.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-user.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-payment.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-carts.yaml -n test	
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-load-test.yaml -n test
	kubectl delete -f ./tekton/PipelineResource/PipelineResource-e2e-js-test.yaml -n  test
