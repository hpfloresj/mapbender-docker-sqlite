#FROM php:7.0-fpm
FROM php:7.2-fpm

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
		zlib1g-dev \
    libzip-dev \
		libbz2-dev \
    libxml2-dev \
		libwebp-dev \
		libjpeg-dev \
		libpng-dev \
		libxmp-dev \
		libicu-dev \
		libsqlite3-dev \
    libpq-dev \
    && docker-php-ext-install zip \
	  && docker-php-ext-install bz2 \
	  && docker-php-ext-install xml \
	  && docker-php-ext-install json \
	  && docker-php-ext-install mbstring \
	  && docker-php-ext-install gd \
	  && docker-php-ext-install intl \
	  && docker-php-ext-install pdo_sqlite \
	  && docker-php-ext-install pdo \
	  && docker-php-ext-install pdo_mysql \
	  && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install opcache

#Todo: move this to container layer
# comment out the following lines to disable xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# install composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.0.0

EXPOSE 9000
