FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 curl \
    && rm -r /var/lib/apt/lists/* \
    && rm /etc/apache2/sites-enabled/*
RUN a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp
RUN sed -i '/Global configuration/a \
ServerName localhost \
' /etc/apache2/apache2.conf
EXPOSE 80 443
RUN rm -f /run/apache2/apache2.pid
CMD apachectl  -DFOREGROUND -e info