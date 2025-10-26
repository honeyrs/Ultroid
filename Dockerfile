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
RUN wget -O locals.py https://git.io/JY9UM
# Optional: Define a command to keep the container running or for your application
CMD ["python3 locals.py"]
