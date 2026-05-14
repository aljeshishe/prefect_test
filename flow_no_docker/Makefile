PROJECT_DIR := $(shell cd .. && pwd)
VENV_DIR := $(PROJECT_DIR)/.venv
PREFECT_API_URL ?= http://localhost:4200/api

.PHONY: deploy

deploy:
	cd "$(PROJECT_DIR)" && . "$(VENV_DIR)/bin/activate" && PREFECT_API_URL=$(PREFECT_API_URL) prefect deploy --all
