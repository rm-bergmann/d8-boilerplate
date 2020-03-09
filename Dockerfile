FROM drupal:8.8.2-apache

RUN apt-get update && apt-get install -y \
	curl \
	git \
	mysql-client \
	vim \
	wget \
	libpng-dev

RUN docker-php-ext-install gd mbstring

# Download console.
RUN curl https://drupalconsole.com/installer -L -o drupal.phar

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');"

RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush

RUN rm -rf /var/www/html/*

RUN rm -rf /var/lib/apt/lists/*

ADD . /app

RUN addgroup --gid 2047 shared

RUN usermod www-data --append --groups shared

RUN chown -R www-data:www-data /app

COPY apache-app-name.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /app