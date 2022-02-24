docker build -t httpd .

# Use socat on OSX since we can't bind-mount the unix domain socket.
OS="`uname`"
case $OS in
  'Darwin')
    socat TCP-LISTEN:4444,reuseaddr,fork "UNIX-CLIENT:/tmp/gunicorn.sock" &
    socat_pid=$!
    trap "kill -- $socat_pid" EXIT
    ;;
  *) ;;
esac

docker run --rm --name apache -h localhost -p 8888:80 -p 8843:443 -p 4444 -it -v ~/src/galaxy:/srv/galaxy/server -v $(pwd)/server.crt:/etc/apache2/ssl/server.crt -v $(pwd)/server.key:/etc/apache2/ssl/server.key  httpd
