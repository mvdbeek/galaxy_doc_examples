docker build -t httpd .
docker run --rm --name apache -h localhost -p 8888:80 -p 8843:443 -p 4444 -it -v ~/src/galaxy:/srv/galaxy/server -v $(pwd)/server.crt:/etc/apache2/ssl/server.crt -v $(pwd)/server.key:/etc/apache2/ssl/server.key  httpd
