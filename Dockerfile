FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install  wget \
                        nginx \
                        mariadb-server \
                        php7.3 \
                        php-mysql \
                        php-fpm \
                        php-pdo \
                        php-gd \
                        php-cli \
                        php-mbstring \
                        php-zip \
                        php-xmlrpc \
                        php-xml \
                        php-soap \
                        php-intl \
						openssl \
						vim


WORKDIR /etc/nginx/sites-available/

COPY ./srcs/start.sh ./

#NGINX CONF
COPY ./srcs/default /etc/nginx/sites-available/default

#SSL
RUN openssl req \
       -newkey rsa:2048 -nodes -keyout /etc/ssl/private/localhost.key \
       -x509 -out /etc/ssl/certs/localhost.crt \
       -subj '/C=RU'

#PHP
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY ./srcs/config.inc.php phpmyadmin/

#WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php ./ 
WORKDIR /etc/nginx/sites-available/


EXPOSE 80 443

CMD bash ./start.sh


