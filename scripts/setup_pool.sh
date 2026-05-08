#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"
source "$PROJECT_DIR/.venv/bin/activate"

echo "=== Create work pool and configure networking ==="
prefect work-pool create "$WORK_POOL_NAME" --type docker 2>/dev/null || echo "Work pool already exists."

python3 - <<'PYEOF'
import json
import subprocess

pool_name = "docker-pool"
network_name = "prefect-network"
api_url = "http://prefect-server:4200/api"

result = subprocess.run(
    ["prefect", "work-pool", "get-default-base-job-template", "--type", "docker"],
    capture_output=True, text=True, check=True
)
template = json.loads(result.stdout)

props = template.get("variables", {}).get("properties", {})

if "networks" in props:
    props["networks"]["default"] = [network_name]

if "env" in props:
    props["env"]["default"] = {"PREFECT_API_URL": api_url}

if "image_pull_policy" in props:
    props["image_pull_policy"]["default"] = "Never"

with open("/tmp/base-job-template.json", "w") as f:
    json.dump(template, f, indent=2)

subprocess.run(
    ["prefect", "work-pool", "update", pool_name,
     "--base-job-template", "/tmp/base-job-template.json"],
    check=True
)
print("Work pool updated with network and env configuration.")
PYEOF
