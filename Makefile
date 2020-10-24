make up: init logging monitoring deploy-website

init:
	cd k8s-sandbox && make up && make install-cicd && make install-ingress && cd ..
logging:
	cd k8s-sandbox && make install-logging && cd ..
monitoring:
	cd k8s-sandbox && make install-monitoring && cd ..
deploy-website:
	kubectl create namespace test
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

