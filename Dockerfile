# -------------------------------------------------
#  Base image
# -------------------------------------------------
FROM python:3.10-slim

# -------------------------------------------------
#  System dependencies (git, curl, build tools, libs)
# -------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        wget \
        build-essential \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# -------------------------------------------------
#  Upgrade pip & install Python requirements
# -------------------------------------------------
WORKDIR /root/TeamUltroid
COPY . .

# Install the *exact* packages that were reported missing
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        Pillow \      # provides cv2 (no GUI)
        apscheduler \
        profanitydetector \
        qrcode[pil] \
        pytz \
        twikit \
        htmlwebshot \
        yt-dlp \
        akipy && \
    pip install --no-cache-dir -r requirements.txt

# -------------------------------------------------
#  Entrypoint
# -------------------------------------------------
CMD ["bash", "startup"]
