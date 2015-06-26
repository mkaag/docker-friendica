#!/bin/bash

set -eo pipefail

echo "[nginx] starting nginx service..."
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf
