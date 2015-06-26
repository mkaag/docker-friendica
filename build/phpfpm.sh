#!/bin/bash

set -eo pipefail

echo "[php5-fpm] starting php5-fpm service..."
/usr/sbin/php5-fpm -c /etc/php5/fpm &