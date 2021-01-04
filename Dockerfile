FROM wordpress:5.5.1 as app

RUN echo 'I WUZ HERE!!!!!!!!!!!!!' >> /usr/src/wordpress/wp-admin/install.php
