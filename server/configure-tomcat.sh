#!/usr/bin/env bash

set -x
set -e

#
# Configure server.xml
#
# Parameter 1: the FQDN of the proxy server (e.g. confluence.software-craftsmen.at
# Parameter 2: the context path (e.g. /confluence). If it is "/" the context will be assumed as ""
# Parameter 3: the path of the tomcat configuration file (server.xml)
#
function configureTomcat {
    #https://confluence.atlassian.com/jirakb/integrating-jira-with-nginx-426115340.html

    local proxyPort="443"
    local proxyName=${1}
    local contextPath=${2}
    local tomcatServerXml=${3}

    if [ "${contextPath}" == "/" ]; then
         contextPath=""
    fi

    xmlstarlet ed --pf --inplace --update Server/Service/Engine/Host/Context[1]/@path -v "${contextPath}" ${tomcatServerXml}

    xmlstarlet ed --pf --inplace --delete 'Server/Service/Connector/@proxyName' ${tomcatServerXml}
    xmlstarlet ed --pf --inplace --delete 'Server/Service/Connector/@proxyPort' ${tomcatServerXml}
    xmlstarlet ed --pf --inplace --delete 'Server/Service/Connector/@scheme' ${tomcatServerXml}
    xmlstarlet ed --pf --inplace --delete 'Server/Service/Connector/@secure' ${tomcatServerXml}

    if [ -n "${proxyName}" ]; then
        xmlstarlet ed --pf --inplace --insert Server/Service/Connector --type attr -n proxyName --value "$proxyName" ${tomcatServerXml}
        xmlstarlet ed --pf --inplace --insert Server/Service/Connector --type attr -n proxyPort --value "${proxyPort}"  ${tomcatServerXml}
        xmlstarlet ed --pf --inplace --insert Server/Service/Connector --type attr -n scheme --value "https"  ${tomcatServerXml}
        xmlstarlet ed --pf --inplace --insert Server/Service/Connector --type attr -n secure --value "true"  ${tomcatServerXml}
    fi
}
