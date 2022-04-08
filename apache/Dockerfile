FROM httpd:2.4

RUN apt update && apt install -y socat curl

RUN mkdir -p /srv/galaxy/var/

RUN curl -k -L https://github.com/tus/tusd/releases/download/v1.9.0/tusd_linux_amd64.tar.gz --output tusd.tgz
RUN tar -xvzf tusd.tgz && cp tusd_linux_amd64/tusd /usr/local/bin

COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY entrypoint.sh /usr/local/bin/
CMD ["entrypoint.sh"]
