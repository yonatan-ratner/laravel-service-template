# syntax=docker/dockerfile:1

# Stage 1: Composer
FROM composer:2.7.6 AS composer
WORKDIR /app
COPY example-project/composer.json ./
COPY example-project/composer.lock ./
RUN composer install --ignore-platform-reqs --no-scripts

# Stage 2: PHP
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

# Copy Composer from the Composer stage
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/app

# Copy application files
COPY example-project .

# Copy composer dependencies from Composer stage
COPY --from=composer /app/vendor ./vendor

# Set proper permissions for Laravel directories
RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache

# Copy .env.example to .env
RUN cp .env.example .env

# Debug: Check the content of the .env file to ensure it's copied
RUN cat .env

# Generate application key (should happen once per clone)
RUN php artisan key:generate

# Ensure proper permissions
RUN chmod -R 775 storage bootstrap/cache

# Set permissions
RUN chown -R www-data:www-data .
