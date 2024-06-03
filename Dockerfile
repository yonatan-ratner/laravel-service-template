# syntax=docker/dockerfile:1

FROM composer:2.7.6
FROM php:8.3.7-fpm-alpine3.20

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
COPY --from=0 /usr/bin/composer /usr/bin/composer

# copy composer.json to workdir & install dependencies
## Change ./product-api to your Projects name!
COPY ./product-api/composer.json ./
#RUN composer dump-autoload 
RUN composer install 
#RUN composer update

# Set the default command to run php-fpm
CMD ["php-fpm"]