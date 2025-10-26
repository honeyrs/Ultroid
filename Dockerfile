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
        build-essential 

# -------------------------------------------------
#  Upgrade pip & install Python requirements
# -------------------------------------------------
WORKDIR /root/TeamUltroid
COPY . .

# Install the *exact* packages that were reported missing
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# -------------------------------------------------
#  Entrypoint
# -------------------------------------------------
CMD python3 -m pyUltroid
