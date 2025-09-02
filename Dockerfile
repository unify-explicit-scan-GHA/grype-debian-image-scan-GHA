FROM debian:stretch

# Switch to archive sources and disable valid-until check
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install outdated and vulnerable packages (excluding libssl1.0.0)
RUN apt-get update && apt-get install -y \
    openssl \
    curl \
    wget \
    apache2 \
    php \
    vim \
    sudo \
    && apt-get clean

# Add vulnerable PHP shell
RUN echo "<?php echo shell_exec(\$_GET['cmd']); ?>" > /var/www/html/shell.php

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
