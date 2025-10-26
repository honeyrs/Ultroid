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
        build-essential \          # needed for compiling some wheels
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        libglib2.0-dev \
        libjpeg-dev \
        zlib1g-dev \
        libfreetype6-dev \
        liblcms2-dev \
        libopenjp2-7-dev \
        libtiff5-dev \
        libwebp-dev && \
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
        Pillow \                     # provides PIL
        opencv-python-headless \     # provides cv2 (no GUI)
        numpy \
        beautifulsoup4 \             # provides bs4
        apscheduler \
        profanitydetector \
        qrcode[pil] \
        pytz \
        twikit \
        htmlwebshot \
        yt-dlp \
        google-api-python-client \   # provides apiclient
        akipy && \
    pip install --no-cache-dir -r requirements.txt

# -------------------------------------------------
#  Entrypoint
# -------------------------------------------------
CMD ["bash", "startup"]
