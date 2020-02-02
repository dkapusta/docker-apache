FROM php:7.2-apache

RUN apt-get update && apt-get install -y git \
    && apt-get install -y libicu-dev zlib1g-dev libmemcached-dev libmagickwand-dev libpq-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/local/include --with-png-dir=/usr/local/include \
    && docker-php-ext-install -j$(nproc) intl bcmath zip bz2 pdo pdo_mysql pdo_pgsql gd pcntl \
    && pecl install memcached imagick mongodb ; docker-php-ext-enable memcached imagick mongodb \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite
RUN a2enmod headers
RUN service apache2 restart

WORKDIR /var/www/html