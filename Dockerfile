FROM linuxserver/sonarr as build

RUN apk update && apk add --no-cache \
        git \
        python3 \
        py3-pip \
        py3-virtualenv

RUN mkdir /sickbeard_mp4_automator/ && \
    git config --global --add safe.directory /sickbeard_mp4_automator/ && \
    git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /sickbeard_mp4_automator/

RUN python3 -m virtualenv /sickbeard_mp4_automator/venv && \
    /sickbeard_mp4_automator/venv/bin/pip install -r /sickbeard_mp4_automator/setup/requirements.txt

FROM linuxserver/sonarr

RUN apk add --no-cache \
        ffmpeg \
        curl \
        python3

RUN mkdir /sickbeard_mp4_automator/

COPY --from=build /sickbeard_mp4_automator/ /sickbeard_mp4_automator/
