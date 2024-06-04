# syntax=docker/dockerfile:1

FROM php:8.3.7-fpm-alpine3.20 as runtime

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

# Set the working directory
## Change example-project to your Projects name!
COPY ./example-project /var/www/app 
WORKDIR /var/www/app

RUN chown -R www-data:www-data /var/www/app \
    && chmod -R 775 /var/www/app/storage

## install composer ##
FROM composer:2.7.6 as pkg-manager
COPY --from=0 /usr/bin/composer /usr/bin/composer

# copy composer.json to workdir & install dependencies
## Change ./example-project to your projects name!
COPY ./example-project/composer.json ./
RUN composer install 

# Set the default command to run php-fpm
CMD ["php-fpm"]