# Ultroid - UserBot
# Copyright (C) 2021-2025 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# PLease read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Uninstall the system Python and related packages (if present)
RUN apt-get update && apt-get remove -y \
    python3 \
    python3-pip \
    python3-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Python 3.11 from source
RUN wget https://www.python.org/ftp/python/3.11.10/Python-3.11.10.tar.xz \
    && tar -xf Python-3.11.10.tar.xz \
    && cd Python-3.11.10 \
    && ./configure --enable-optimizations \
    && make -j$(nproc) \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.11.10 Python-3.11.10.tar.xz

# Ensure pip is installed for Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && /usr/local/bin/python3.11 get-pip.py \
    && rm get-pip.py

# Verify Python 3.11 is the default python3
RUN ln -sf /usr/local/bin/python3.11 /usr/bin/python3 \
    && ln -sf /usr/local/bin/pip3.11 /usr/bin/pip3

# Copy and run installer.sh
COPY installer.sh .
RUN bash installer.sh

# Changing workdir
WORKDIR "/root/TeamUltroid"

# Start the bot
CMD ["bash", "startup"]
