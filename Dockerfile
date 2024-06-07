# syntax=docker/dockerfile:1
FROM composer:2.7.6
# Set the working directory
WORKDIR /var/www/app
COPY . /var/www/app 

COPY ./composer.json ./
COPY --from=composer:0 /usr/bin/composer /usr/bin/composer

FROM php:8.3.7-fpm-alpine3.20
# Install common php extension dependencies
RUN apk update && apk add \
    bash \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    zlib-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip



RUN chown -R www-data:www-data .
