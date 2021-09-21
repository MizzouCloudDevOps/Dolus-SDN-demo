FROM mizzouceri/dolus-controller:devops
WORKDIR /var/www
RUN mv html public_html && cd public_html
RUN git clone https://github.com/wangso/Dolus_DDos 
WORKDIR /var/www/public_html/Dolus_DDos
RUN chmod -R 777 /var/www/ \
    && chmod -R 774 /var/www/public_html/Dolus_DDos \
    && composer install \
    && chmod -R 755 /var/www/public_html/Dolus_DDos \
    && chmod -R 777 storage \
    && chmod -R 775 .env \
    && php artisan key:generate


 
