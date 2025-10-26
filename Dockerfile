# syntax=docker/dockerfile:1.3-labs
FROM python:3.10-slim

ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    ffmpeg \
    libsm6 \
    libxext6 \
    cmake \
    rsync \
    libgl1-mesa-glx \
    curl \
    && rm -rf /var/lib/apt/lists/* && \
    git lfs install

COPY installer.sh .

RUN bash installer.sh


WORKDIR "/root/TeamUltroid"

# start the bot.
CMD ["bash", "startup"]
