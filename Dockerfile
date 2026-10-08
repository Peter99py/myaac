FROM php:8.2-fpm-alpine
WORKDIR /var/www/html
COPY . .
RUN apk add --no-cache nginx curl git unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader \
    && cp nginx-sample.conf /etc/nginx/http.d/default.conf \
    && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php82/php.ini
EXPOSE 80
CMD ["sh", "-c", "nginx && php-fpm"]
