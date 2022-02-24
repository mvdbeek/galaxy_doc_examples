FROM httpd:2.4

RUN apt update && apt install -y socat

RUN mkdir -p /srv/galaxy/var/

COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY entrypoint.sh /usr/local/bin/
CMD ["entrypoint.sh"]
