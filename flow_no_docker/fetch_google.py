import requests
from prefect import flow, task, get_run_logger


@task
def fetch_url(url: str) -> int:
    logger = get_run_logger()
    resp = requests.get(url, timeout=10)
    logger.info(f"Status: {resp.status_code}, Length: {len(resp.text)}")
    return resp.status_code


@flow(name="fetch-google-no-docker", log_prints=True)
def fetch_google():
    status = fetch_url("https://www.google.com")
    print(f"Google status: {status}")
    return status


if __name__ == "__main__":
    fetch_google()
