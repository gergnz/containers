FROM oraclelinux:7

RUN yum-config-manager --enable ol7_optional_latest ol7_addons ol7_software_collections ol7_oracle_instantclient

RUN yum group install -y "Development Tools"

RUN yum install -y rh-php72-php-devel rh-php72-php rh-php72 oracle-instantclient18.3-devel oracle-instantclient18.3-tools rh-php72-php-mysqlnd rh-php72-php-mbstring

RUN source /opt/rh/rh-php72/enable && \
    printf "\n" | pecl install oci8 && \
    echo "extension=oci8.so" > /etc/opt/rh/rh-php72/php.d/20-oci8.ini

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y libmcrypt-devel

RUN source /opt/rh/rh-php72/enable && \
    printf "\n" | pecl install channel://pecl.php.net/mcrypt-1.0.2

RUN echo "extension=mcrypt.so" > /etc/opt/rh/rh-php72/php.d/20-mcrypt.ini

WORKDIR /tmp
RUN source /opt/rh/rh-php72/enable && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN usermod -s /bin/bash apache

RUN echo "source /opt/rh/rh-php72/enable" > /etc/profile.d/php72.sh

WORKDIR /app
