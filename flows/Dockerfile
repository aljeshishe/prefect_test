FROM prefecthq/prefect:3-latest

COPY requirements.txt /opt/prefect/requirements.txt
RUN pip install --no-cache-dir -r /opt/prefect/requirements.txt

COPY fetch_google.py /opt/prefect/fetch_google.py
