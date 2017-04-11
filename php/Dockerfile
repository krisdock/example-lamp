FROM php:7.0-apache

RUN apt-get update \
  && apt-get install -y mysql-client curl \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives
  
COPY html/ /var/www/html/
COPY script/ /tmp/
