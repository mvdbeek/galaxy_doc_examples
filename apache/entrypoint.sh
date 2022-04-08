#!/bin/sh
set -xe

umask 0
socat UNIX-LISTEN:/srv/galaxy/var/gunicorn.sock,fork TCP:host.docker.internal:4444 &
# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

# Start tusd server
tusd -host localhost -behind-proxy -port 1080 -upload-dir=/tmp -hooks-http=http://host.docker.internal:4444/api/upload/hooks -hooks-http-forward-headers=X-Api-Key,Cookie -base-path=/api/upload/resumable_upload &

exec httpd -DFOREGROUND "$@"
