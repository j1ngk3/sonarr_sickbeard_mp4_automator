import pytest

def test_manual_conversion(host):
    msg = "Relocating MOOV atom to start of file"
    command = """curl -O https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4 && \
                 /sickbeard_mp4_automator/venv/bin/python /sickbeard_mp4_automator/manual.py -i "./BigBuckBunny_320x180.mp4" -a -nd -nt"""

    cmd = host.run(command)

    assert msg in cmd.stdout