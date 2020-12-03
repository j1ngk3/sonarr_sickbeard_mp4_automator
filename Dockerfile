# Version 1.2
FROM linuxserver/sonarr

RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg \
        git \
        build-essential \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        openssl \
        python3-dev \
        libffi-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*       

RUN git clone git://github.com/mdhiggins/sickbeard_mp4_automator.git /sickbeard_mp4_automator/ && \  
    touch /sickbeard_mp4_automator/info.log && \ 
    chmod a+rwx -R /sickbeard_mp4_automator

RUN pip3 install -r /sickbeard_mp4_automator/setup/requirements.txt && \
    pip3 install -r /sickbeard_mp4_automator/setup/requirements-deluge.txt && \
    pip3 install -r /sickbeard_mp4_automator/setup/requirements-qbittorrent.txt
