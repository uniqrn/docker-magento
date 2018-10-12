FROM php:7.1-apache

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \ 
    sudo \ 
    cron \ 
    rsyslog \ 
    mysql-client \
    git \
    redis-tools

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  dom \
  gd \
  intl \
  mbstring \
  mcrypt \
  pcntl \
  pdo_mysql \
  xsl \
  zip \
  bcmath \
  opcache \
  soap \
  sockets

RUN pecl install -o -f xdebug

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/html/magento

ENV DEBUG false
ENV M2_SAMPLE_DATA false
ENV COMPOSER_ALLOW_SUPERUSER 1

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite expires
