FROM mkaag/phpfpm:latest
MAINTAINER Maurice Kaag <mkaag@me.com>

# -----------------------------------------------------------------------------
# Environment variables
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Pre-install
# -----------------------------------------------------------------------------
RUN \
    sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list && \
    wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list && \
    apt-get update -qqy

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
RUN \
    apt-get install -qqy \
        php5-mysql \
        nginx-common \
        nginx-extras \
        nginx-nr-agent \
        newrelic-sysmond

WORKDIR /opt
RUN \
  git clone https://github.com/friendica/friendica.git && \
  git clone https://github.com/friendica/friendica-addons.git friendica/addon && \
  chmod 777 friendica/view/smarty3

# -----------------------------------------------------------------------------
# Post-install
# -----------------------------------------------------------------------------
ADD build/phpfpm.sh /etc/my_init.d/13_phpfpm.sh
ADD build/nginx.sh /etc/my_init.d/14_nginx.sh
ADD build/nginx.conf /etc/nginx/sites-enabled/friendica
ADD build/status.conf /etc/nginx/conf.d/status.conf

RUN \
    sed -i "s/\/opt\/friendica/" /etc/php5/fpm/php.ini && \
    rm /etc/nginx/sites-enabled/default && \
    chmod +x /etc/my_init.d/13_phpfpm.sh && \
    chmod +x /etc/my_init.d/14_nginx.sh

EXPOSE 80 443

CMD ["/sbin/my_init"]

# -----------------------------------------------------------------------------
# Clean up
# -----------------------------------------------------------------------------
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
