# Use Python 3.10 slim as the base image
FROM python:3.10-slim

# Install git, curl, and ensure pip is up-to-date
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade pip

# Set the working directory
WORKDIR "/root/TeamUltroid"
COPY . .
RUN pip3 install -U -r requirements.txt

CMD ["bash", "startup"]
