NAME = weaveworksdemos/payment
INSTANCE = payment

.PHONY: default copy test

build:
	docker build --tag payment .

default: test

copy:
	docker create --name $(INSTANCE) $(NAME)-dev
	docker cp $(INSTANCE):/app/main $(shell pwd)/app
	docker rm $(INSTANCE)

release:
	docker build -t $(NAME) -f ./docker/payment/Dockerfile-release .

test:
	GROUP=weaveworksdemos COMMIT=$(COMMIT) ./scripts/build.sh
	./test/test.sh unit.py
	./test/test.sh container.py --tag $(COMMIT)


buildlocal:
	docker build -t payment .

runlocal:
	docker run -it --rm -d -p 8034:80 payment

testlocal:
	curl localhost:8034/health | jq
