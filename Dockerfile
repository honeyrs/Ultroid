FROM python:3.9.23-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ffmpeg \
    fastfetch \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/SyntaxAdi/Ultroid /app

WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["bash", "startup"]
