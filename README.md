# sonarr_sickbeard_mp4_automator

A [`linuxserver/sonarr`](https://hub.docker.com/r/linuxserver/sonarr) Docker image with [sickbeard_mp4_automator](https://github.com/mdhiggins/sickbeard_mp4_automator) baked in, so Sonarr can automatically transcode/post-process downloads (e.g. to MP4/h.264) without any extra manual setup inside the container.

## What's in the image

- Base: `linuxserver/sonarr`
- [`sickbeard_mp4_automator`](https://github.com/mdhiggins/sickbeard_mp4_automator) cloned and installed into its own Python virtualenv at `/sickbeard_mp4_automator/`
- `ffmpeg`, `curl`, and `python3` added to the runtime image

## Pulling the image

```bash
docker pull jingke/sonarr_sickbeard_mp4_automator:latest
```

## Usage

Run it exactly like you would the standard `linuxserver/sonarr` image — it accepts the [same environment variables and volumes](https://docs.linuxserver.io/images/docker-sonarr/) (`PUID`, `PGID`, `TZ`, config/media volume mounts, etc.).

```bash
docker run -d \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 8989:8989 \
  -v /path/to/sonarr/config:/config \
  -v /path/to/tvseries:/tv \
  -v /path/to/downloads:/downloads \
  --restart unless-stopped \
  jingke/sonarr_sickbeard_mp4_automator:latest
```

Or with docker-compose:

```yaml
version: "3"
services:
  sonarr:
    image: jingke/sonarr_sickbeard_mp4_automator:latest
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - /path/to/sonarr/config:/config
      - /path/to/tvseries:/tv
      - /path/to/downloads:/downloads
    ports:
      - 8989:8989
    restart: unless-stopped
```

Once running, configure sickbeard_mp4_automator itself (`autoProcess.ini`, etc.) inside `/sickbeard_mp4_automator/` and point Sonarr's "Custom Script" connection at `/sickbeard_mp4_automator/venv/bin/python /sickbeard_mp4_automator/sonarrProcess.py`. See the [sickbeard_mp4_automator wiki](https://github.com/mdhiggins/sickbeard_mp4_automator/wiki) for full configuration details.

## Building locally

```bash
./build.sh
```

or

```bash
docker compose -f docker-compose.build.yaml build
```

## Credits

- [linuxserver/sonarr](https://github.com/linuxserver/docker-sonarr)
- [mdhiggins/sickbeard_mp4_automator](https://github.com/mdhiggins/sickbeard_mp4_automator)