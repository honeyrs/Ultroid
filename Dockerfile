FROM theteamultroid/ultroid:main

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package lists and install prerequisites
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3-launchpadlib \
    ca-certificates \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update

# Uninstall the system Python and related packages (if present)
RUN apt-get remove -y \
    python3 \
    && apt-get autoremove -y \
    && apt-get clean

# Install Python 3.11 and related packages
RUN apt-get install -y \
    python3.11 \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Ensure pip is installed and up-to-date for Python 3.11
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 \
    && python3.11 -m pip install --upgrade pip

# Verify Python 3.11 is the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && update-alternatives --set python3 /usr/bin/python3.11

# Copy and run installer.sh
COPY installer.sh .
RUN bash installer.sh

# Changing workdir
WORKDIR "/root/TeamUltroid"

# Start the bot
CMD ["bash", "startup"]
