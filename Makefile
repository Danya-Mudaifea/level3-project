up: build run

elf-graf : logging monitoring  

build:
	cd k8s-sandbox && make up && make install-cicd && make install-ingress && cd .. && kubectl create namespace test && kubectl create namespace prod && make secret-docker

secret-docker:
	docker login 		
	kubectl create secret generic danyacreds \
 	--from-file=.dockerconfigjson=/home/ubuntu/.docker/config.json \
 	--type=kubernetes.io/dockerconfigjson -n test

logging:
	cd k8s-sandbox && make install-logging && cd ..
monitoring:
	cd k8s-sandbox && make install-monitoring && cd ..

run:
	make resource && make build_deploy && make pipeline && make pipelinerun && make logging && make monitoring


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
	kubectl create -f ./tekton/tasks/wait-pods.yaml -n test
	kubectl create -f ./tekton/tasks/run-e2e.yaml -n test
	kubectl apply -f ./tekton/tasks/deploy-task-prod.yaml -n test
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
	kubectl create -f ./tekton/pipeline/pipeline-e2e-js-test.yaml -n  test

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
	kubectl create -f ./tekton/pipelinerun/PipelineRun-e2e-js-test.yaml -n  test


down: 
	cd k8s-sandbox && make down && cd ..
delete-all:
	kubectl delete -f ./tekton/role.yaml -n test -f ./tekton/role-binding.yaml -n test -f ./tekton/sa-front-end.yaml -n test
	cd tekton
	cd pipeline && kubectl delete -f . -n test && cd ..
	cd PipelineResource && kubectl delete -f . -n test && cd .. 
	cd tasks && kubectl delete -f . -n test && cd .. 
	cd pipelinerun && kubectl delete -f . -n test && cd ..
	cd .. 

	
