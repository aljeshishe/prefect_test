FLOW_IMAGE ?= prefect-flows:latest

.PHONY: build deploy

build:
	docker build -t $(FLOW_IMAGE) .

deploy: build
	python3 deploy_flow.py
