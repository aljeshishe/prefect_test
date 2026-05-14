#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

make -C "$PROJECT_DIR/prefect_infra" install
make -C "$PROJECT_DIR/prefect_infra" up

make -C "$PROJECT_DIR/prefect_infra" setup-pool

source "$PROJECT_DIR/.venv/bin/activate"
make -C "$PROJECT_DIR/flows" deploy

echo ""
echo "=== Done! ==="
echo "  UI:  http://localhost:4200"
echo "  Flow 'fetch-google' is deployed and runs every 60 seconds."
