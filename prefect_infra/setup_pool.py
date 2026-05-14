import asyncio
from prefect.client.orchestration import get_client
from prefect.client.schemas.actions import WorkPoolUpdate
from prefect.workers.utilities import get_default_base_job_template_for_infrastructure_type

POOL_NAME = "docker-pool"
NETWORK_NAME = "prefect-network"
API_URL = "http://prefect-server:4200/api"


async def main():
    template = await get_default_base_job_template_for_infrastructure_type("docker")
    if template is None:
        raise RuntimeError("Failed to get base job template for docker")

    props = template.get("variables", {}).get("properties", {})

    if "networks" in props:
        props["networks"]["default"] = [NETWORK_NAME]

    if "env" in props:
        props["env"]["default"] = {"PREFECT_API_URL": API_URL}

    if "image_pull_policy" in props:
        props["image_pull_policy"]["default"] = "Never"

    async with get_client() as client:
        await client.update_work_pool(
            work_pool_name=POOL_NAME,
            work_pool=WorkPoolUpdate(base_job_template=template),
        )

    print("Work pool updated with network and env configuration.")


if __name__ == "__main__":
    asyncio.run(main())
