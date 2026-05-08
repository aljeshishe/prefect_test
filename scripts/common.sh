#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PREFECT_API_URL="http://localhost:4200/api"
WORK_POOL_NAME="docker-pool"
FLOW_IMAGE="prefect-flows:latest"

export PREFECT_API_URL
