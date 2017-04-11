FROM php:7.0-apache

COPY html/ /var/www/html/
COPY script/ /tmp/

RUN apt-get -qq update \
  && apt-get -y install mysql-client \
  && apt-get -y install curl \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives