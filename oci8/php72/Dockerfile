FROM oraclelinux:7

RUN yum-config-manager --enable ol7_optional_latest ol7_addons ol7_software_collections ol7_oracle_instantclient

RUN yum group install -y "Development Tools"

RUN yum install -y rh-php72-php-devel rh-php72-php rh-php72 oracle-instantclient18.3-devel oracle-instantclient18.3-tools

RUN source /opt/rh/rh-php72/enable && \
    printf "\n" | pecl install oci8 && \
    echo "extension=oci8.so" > /etc/opt/rh/rh-php72/php.d/20-oci8.ini
