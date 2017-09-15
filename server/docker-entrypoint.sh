#!/usr/bin/env bash
set -x

source /configure-tomcat.sh
configureTomcat "${NGINX_SERVER_NAME}" "/${CONFLUENCE_CONTEXT_PATH}" /opt/atlassian/confluence/conf/server.xml

source /configure-confluence.sh
configureConfluence "/${CONFLUENCE_CONTEXT_PATH}" /var/atlassian/application-data/confluence/confluence.cfg.xml

# Adjust this path if the installation location has been modified by the response.varfile
exec /opt/atlassian/confluence/bin/start-confluence.sh -fg
