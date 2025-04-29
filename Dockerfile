FROM php:8.1-apache

RUN apt-get update && apt-get install -y unzip git \
    && docker-php-ext-install pdo pdo_mysql

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY app/ /var/www/html/
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
