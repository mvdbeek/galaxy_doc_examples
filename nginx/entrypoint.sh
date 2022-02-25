#!/bin/sh
set -e

umask 0
socat UNIX-LISTEN:/srv/galaxy/var/gunicorn.sock,fork TCP:host.docker.internal:4444 &

exec nginx -g "daemon off;" "$@"
