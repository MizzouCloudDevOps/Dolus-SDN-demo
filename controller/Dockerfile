FROM mizzouceri/dolus-controller:devops
RUN mv /var/www/html /var/www/public_html 
RUN git clone https://github.com/wangso/Dolus_DDos.git /var/www/public_html/Dolus_DDos 
RUN chmod -R 777 /var/www/ && chmod -R 774 /var/www/public_html/Dolus_DDos
WORKDIR /var/www/public_html/Dolus_DDos && composer install
RUN chmod -R 755 /var/www/public_html/Dolus_DDos \
    && chmod -R 777 storage \
    && chmod -R 775 .env \
    && php artisan key:generate
