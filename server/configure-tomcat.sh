#!/usr/bin/env bash

set -x
set -e

function configureTomcat {
    #https://confluence.atlassian.com/jirakb/integrating-jira-with-nginx-426115340.html

    local proxyPort="443"
    local proxyName=${1}
    local contextPath=${2}
    local tomcatServerXml=${3}

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
