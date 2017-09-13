#!/usr/bin/env bash
set -x

source /configure-tomcat.sh
configureTomcat "${NGINX_SERVER_NAME}" "/${CONFLUENCE_CONTEXT_PATH}" /opt/atlassian/confluence/conf/server.xml

# Adjust this path if the installation location has been modified by the response.varfile
exec /opt/atlassian/confluence/bin/start-confluence.sh -fg
