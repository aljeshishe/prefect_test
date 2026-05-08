PROJECT_DIR := $(shell cd .. && pwd)
VENV_DIR := $(PROJECT_DIR)/.venv
PREFECT_API_URL ?= http://localhost:4200/api

.PHONY: install up down

install:
	@if [ ! -d "$(VENV_DIR)" ]; then uv venv --python 3.10 "$(VENV_DIR)"; fi
	. "$(VENV_DIR)/bin/activate" && uv pip install prefect prefect-docker

up:
	docker compose up -d
	@echo "Waiting for Prefect server to be healthy..."
	@for i in $$(seq 1 60); do \
		if curl -sf "$(PREFECT_API_URL)/health" > /dev/null 2>&1; then \
			echo "Prefect server is healthy."; \
			break; \
		fi; \
		if [ "$$i" -eq 60 ]; then \
			echo "ERROR: Prefect server did not become healthy in time."; \
			exit 1; \
		fi; \
		sleep 3; \
	done

down:
	docker compose down
