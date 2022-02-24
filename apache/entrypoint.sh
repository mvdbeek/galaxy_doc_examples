#!/bin/sh
set -e

umask 0
socat UNIX-LISTEN:/srv/galaxy/var/gunicorn.sock,fork TCP:docker.for.mac.localhost:4444 &
# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

exec httpd -DFOREGROUND "$@"
