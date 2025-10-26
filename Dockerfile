# ------------------------------------------------------------
# Ultroid - UserBot (Python 3.10.12)
# Copyright (C) 2021-2025 TeamUltroid
# ------------------------------------------------------------
FROM python:3.10.12-slim

# ---- Environment -------------------------------------------------
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive

# ---- Timezone ----------------------------------------------------
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# ---- System dependencies (required by Ultroid) ------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ffmpeg \
        libffi-dev \
        libjpeg-dev \
        libwebp-dev \
        libmagic-dev \
        build-essential \
        ca-certificates \
        curl \
        wget && \
    rm -rf /var/lib/apt/lists/*

# ---- Copy & run the installer ------------------------------------
COPY installer.sh /tmp/install757.sh
RUN chmod +x /tmp/install757.sh && \
    /tmp/install757.sh && \
    rm /tmp/install757.sh

# ---- Working directory -------------------------------------------
WORKDIR /root/TeamUltroid

# ---- Start the bot -----------------------------------------------
CMD ["bash", "startup"]
