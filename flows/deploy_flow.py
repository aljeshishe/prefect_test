from fetch_google import fetch_google

if __name__ == "__main__":
    fetch_google.deploy(
        name="fetch-google-every-minute",
        work_pool_name="docker-pool",
        image="prefect-flows:latest",
        build=False,
        push=False,
        interval=60,
    )
    print("Deployment created successfully.")
