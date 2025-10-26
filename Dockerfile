# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# Please read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

# Use Python 3.11 slim image as the base
FROM python:3.11-slim

# Set timezone to Asia/Kolkata
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set working directory
WORKDIR /root/TeamUltroid

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    git \
    ffmpeg \
    mediainfo \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the installer script
COPY installer.sh .

# Ensure the installer script is executable
RUN chmod +x installer.sh

# Run the installer script with default parameters
RUN bash installer.sh --no-root

# Install additional dependencies based on environment variables (if set)
# These will be checked at runtime, but we pre-install common ones
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    pymongo[srv] \
    psycopg2-binary \
    redis \
    hiredis \
    yt-dlp \
    playwright \
    pytgcalls \
    av && \
    playwright install

# Start the bot
CMD ["bash", "startup"]
