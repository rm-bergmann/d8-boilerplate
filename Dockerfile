FROM drupal:8.8.2-apache

USER root

RUN apt-get update && apt-get install -y \
	curl \
	git \
	mysql-client \
	vim \
	wget \
	libpng-dev

RUN docker-php-ext-install gd mbstring

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

RUN rm -rf /var/www/html/*

COPY --chown=www-data:www-data . /app

WORKDIR /app

# These take too long...
# ADD --chown=www-data:www-data . /app

# COPY . /app

# RUN chown -R www-data:www-data /app
# RUN chmod -R 555 /app
# RUN addgroup --gid 2047 shared
# RUN usermod www-data --append --groups shared
# RUN rm -rf /var/lib/apt/lists/*

COPY apache-app-name.conf /etc/apache2/sites-enabled/000-default.conf

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

RUN composer install

# Install console
# RUN mv drupal.phar /usr/local/bin/drupal && \
#    chmod +x /usr/local/bin/drupal && \
#    drupal init --override

