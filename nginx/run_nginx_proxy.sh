#!/usr/bin/env bash
set -eux

docker build -t nginx .


# Use socat on OSX since we can't bind-mount the unix domain socket,
# but this should work on all default docker bridge setups
socat TCP-LISTEN:4444,reuseaddr,fork "UNIX-CLIENT:/tmp/gunicorn.sock" &
socat_pid=$!
trap "kill -- $socat_pid" EXIT

docker run --rm --name nginx -h localhost --add-host=host.docker.internal:host-gateway -p 80:80 -p 443:443 -p 4444 -it -v ~/src/galaxy:/srv/galaxy/server -v $(pwd)/server.crt:/etc/nginx/ssl/ca.crt  -v $(pwd)/server.crt:/etc/nginx/ssl/server.crt -v $(pwd)/server.key:/etc/nginx/ssl/server.key -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf nginx
