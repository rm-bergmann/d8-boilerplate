FROM drupal:8.9.0-apache

USER root

RUN apt-get update && apt-get install -y \
	curl \
	git \
	default-mysql-client \
	vim \
	wget \
	libpng-dev \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libonig-dev \
	&& docker-php-ext-configure gd \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-enable mysqli

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

RUN rm -rf /var/www/html/*

COPY apache-app-name.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /app

COPY --chown=www-data:www-data . /app

# Composer runs out of memory with composer update / install
# RUN export COMPOSER_MEMORY_LIMIT=-1

# Download console.
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
		mv drupal.phar /usr/local/bin/drupal && \
		chmod +x /usr/local/bin/drupal && \	
		drupal

RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush

RUN composer install -n --no-autoloader --no-scripts --no-progress --no-suggest

