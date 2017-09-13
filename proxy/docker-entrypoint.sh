#!/usr/bin/env bash
set -x
set -e

: ${NGINX_TEMPLATE:=nginx.template}

# If a X.509 certificate matching the proxy server name exists we switch over to the nginx template with SSL enabled
if [ -f "/etc/ssl/certs/${NGINX_SERVER_NAME}.crt" ]; then
    export NGINX_TEMPLATE="nginx-ssl.template"
fi

envsubst "\${NGINX_SERVER_NAME} \${CONFLUENCE_CONTEXT_PATH}" < /etc/nginx/conf.d/${NGINX_TEMPLATE} > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'
