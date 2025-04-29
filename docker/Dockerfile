FROM php:8.2-fpm

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libicu-dev \
    unzip \
    zip \
    git \
    curl \
    pkg-config \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install GD extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install other PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip exif intl mbstring

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create Yii2 basic app
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic .

# Set file permissions
RUN chown -R www-data:www-data /app && chmod -R 755 /app

EXPOSE 9000

CMD ["php", "-S", "0.0.0.0:9000", "-t", "web"]
