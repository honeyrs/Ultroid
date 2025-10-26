# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY installer.sh .

RUN bash installer.sh
# In Dockerfile (use python:3.13-slim or your base)
RUN apt-get update && apt-get install -y \
    build-essential cmake git pkg-config libssl-dev \
    libopus-dev libvpx-dev libx11-dev libwayland-dev libxcomposite-dev \
    libxdamage-dev libxfixes-dev libxrandr-dev libgbm-dev libxkbcommon-dev \
    libpango1.0-dev libcairo2-dev libatk1.0-dev libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

# Then install
RUN pip install tgcalls --no-binary tgcalls --no-cache-dir
# changing workdir
WORKDIR "/root/TeamUltroid"

# start the bot.
CMD ["bash", "startup"]
