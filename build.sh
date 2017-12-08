#!/bin/sh

cd "`dirname $0`"
/usr/local/bin/docker-compose -f docker-compose.build.yaml build --pull "$@"
