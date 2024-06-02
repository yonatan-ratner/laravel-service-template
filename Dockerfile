# syntax=docker/dockerfile:1

# This is php:8.3.7-fpm-alpine3.20 
ARG DIGEST_SHA=php@sha256:e7b38665eec50f09570ac19d55f811cf6a871df954901d9c9422aeeb10c82a07
FROM $DIGEST_SHA as core

# Install common php extension dependencies
RUN apk update && apk add \
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
## Change ./product-api to your Projects name!
COPY ./product-api /var/www/app 
WORKDIR /var/www/app

RUN chown -R www-data:www-data /var/www/app \
    && chmod -R 775 /var/www/app/storage


# install composer
COPY --from=composer:2.6.5 /usr/bin/composer /usr/local/bin/composer

# copy composer.json to workdir & install dependencies
## Change ./product-api to your Projects name!
COPY ./product-api/composer.json ./
RUN composer install

# Set the default command to run php-fpm
CMD ["php-fpm"]