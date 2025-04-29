# Base image with PHP and Apache
FROM php:8.1-apache

# Install required PHP extensions and system packages
RUN apt-get update && apt-get install -y \
        unzip \
        git \
    && docker-php-ext-install pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite for Yii2 URLs
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy Yii2 app code into container
COPY app/ /var/www/html/

# Install Composer (using Composer image as a source)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Yii2 dependencies
RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose web server port
EXPOSE 80
