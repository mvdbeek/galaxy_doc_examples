FROM nginx:1.21.6

RUN apt update && apt install -y socat curl

RUN mkdir -p /srv/galaxy/var/ && mkdir /etc/nginx/ssl
RUN curl https://ssl-config.mozilla.org/ffdhe2048.txt > /etc/nginx/ssl/dhparams.pem

COPY entrypoint.sh /usr/local/bin/
CMD ["entrypoint.sh"]
