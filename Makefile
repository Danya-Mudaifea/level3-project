up: build run

elf-graf : logging monitoring  

build:
	cd k8s-sandbox && make up && make install-cicd && make install-ingress && cd .. && kubectl create namespace test && kubectl create namespace prod && kubectl create namespace logging && kubectl create namespace monitoring && make secret-docker

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

run:
	cd tekton && make run && cd .. && make elf_graf

down: 
	cd k8s-sandbox && make down && make delete-cicd && make delete-ingress && cd ..
logging:
	cd k8s-sandbox && make install-logging && cd ..
monitoring:
	cd k8s-sandbox && make install-monitoring && cd ..

