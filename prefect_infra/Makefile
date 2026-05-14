PROJECT_DIR := $(shell cd .. && pwd)
VENV_DIR := $(PROJECT_DIR)/.venv
PREFECT_API_URL ?= http://localhost:4200/api

WORK_POOL_NAME ?= docker-pool

.PHONY: install up down setup-pool setup-pool-no-docker

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

setup-pool:
	. "$(VENV_DIR)/bin/activate" && prefect work-pool create "$(WORK_POOL_NAME)" --type docker 2>/dev/null || echo "Work pool already exists."
	. "$(VENV_DIR)/bin/activate" && python3 setup_pool.py

setup-pool-no-docker:
	. "$(VENV_DIR)/bin/activate" && prefect work-pool create "no-docker-pool" --type process 2>/dev/null || echo "Work pool 'no-docker-pool' already exists."
