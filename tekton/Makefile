run:
	make resource && make build_deploy && make pipeline && make pipelinerun && make status && make testing 

resource:
	kubectl create -f ./role.yaml -n test
	kubectl create -f ./role-binding.yaml -n test
	kubectl create -f ./sa-front-end.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-front-end.yaml -n test	
	kubectl create -f ./PipelineResource/PipelineResource-catalogue.yaml -n test	
	kubectl create -f ./PipelineResource/PipelineResource-queue-master.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-orders.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-shipping.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-user.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-payment.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-carts.yaml -n test	
	kubectl create -f ./PipelineResource/PipelineResource-load-test.yaml -n test
	kubectl create -f ./PipelineResource/PipelineResource-e2e-js-test.yaml -n  test

build_deploy:
	kubectl create -f ./tasks/build-push-task.yaml -n test
	kubectl create -f ./tasks/deploy-task.yaml -n test

pipeline:
	kubectl create -f ./pipeline/pipeline-front-end.yaml -n test
	kubectl create -f ./pipeline/pipeline-catalogue.yaml -n test
	kubectl create -f ./pipeline/pipeline-queue-master.yaml -n test
	kubectl create -f ./pipeline/pipeline-rabbitmq.yaml -n test
	kubectl create -f ./pipeline/pipeline-orders.yaml -n test
	kubectl create -f ./pipeline/pipeline-shipping.yaml -n test
	kubectl create -f ./pipeline/pipeline-user.yaml -n test
	kubectl create -f ./pipeline/pipeline-payment.yaml -n test
	kubectl create -f ./pipeline/pipeline-carts.yaml -n test
	kubectl create -f ./pipeline/pipeline-load-test.yaml -n test

pipelinerun:
	kubectl create -f ./pipelinerun/PipelineRun-front-end.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-catalogue.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-queue-master.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-rabbitmq.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-orders.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-shipping.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-user.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-payment.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-carts.yaml -n test
	kubectl create -f ./pipelinerun/PipelineRun-load-test.yaml -n test

status: 
	./status.sh

testing:
	kubectl create -f ./tasks/run-e2e.yaml -n test
	kubectl create -f ./tasks/deploy-task-prod.yaml -n  test
	kubectl create -f ./pipeline/pipeline-e2e-js-test.yaml -n  test
	kubectl create -f ./pipelinerun/PipelineRun-e2e-js-test.yaml -n  test
	

pipelinerun-delete:
	kubectl delete -f ./pipelinerun/PipelineRun-front-end.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-catalogue.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-queue-master.yaml -n test	
	kubectl delete -f ./pipelinerun/PipelineRun-rabbitmq.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-orders.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-shipping.yaml -n test	
	kubectl delete -f ./pipelinerun/PipelineRun-user.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-payment.yaml -n test
	kubectl delete -f ./pipelinerun/PipelineRun-load-test.yaml -n test
pipeline-delete:
	kubectl delete -f ./pipeline/pipeline-front-end.yaml -n test
	kubectl delete -f ./pipeline/pipeline-catalogue.yaml -n test
	kubectl delete -f ./pipeline/pipeline-queue-master.yaml -n test
	kubectl delete -f ./pipeline/pipeline-rabbitmq.yaml -n test
	kubectl delete -f ./pipeline/pipeline-orders.yaml -n test
	kubectl delete -f ./pipeline/pipeline-shipping.yaml -n test
	kubectl delete -f ./pipeline/pipeline-user.yaml -n test
	kubectl delete -f ./pipeline/pipeline-payment.yaml -n test
	kubectl delete -f ./pipeline/pipeline-carts.yaml -n test
	kubectl delete -f ./pipeline/pipeline-load-test.yaml -n test

delete-resource:
	kubectl delete -f ./role.yaml -n test
	kubectl delete -f ./role-binding.yaml -n test
	kubectl delete -f ./sa-front-end.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-front-end.yaml -n test	
	kubectl delete -f ./PipelineResource/PipelineResource-catalogue.yaml -n test	
	kubectl delete -f ./PipelineResource/PipelineResource-queue-master.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-orders.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-shipping.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-user.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-payment.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-carts.yaml -n test	
	kubectl delete -f ./PipelineResource/PipelineResource-load-test.yaml -n test
	kubectl delete -f ./PipelineResource/PipelineResource-e2e-js-test.yaml -n  test

