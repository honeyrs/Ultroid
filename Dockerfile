FROM python:3.11

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ffmpeg \
    fastfetch \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/honeyrs/Ultroid /app
RUN pip install --no-cache-dir -r resources/startup/optiona*

WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt
CMD ["bash", "startup"]
