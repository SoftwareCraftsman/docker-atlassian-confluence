#!/usr/bin/env bash

set -x
set -e

#
# Parameter 1: the context path to set
# Parameter 2: the path of the configuration file (e.g. /var/atlassian/application-data/confluence/confluence.cfg.xml)
#
function configureConfluence {
    local contextPath=${1}
    local configurationXml=${2}

    if [ "${contextPath}" == "/" ]; then
         contextPath=""
    fi

    xmlstarlet ed --pf --inplace --update "confluence-configuration/properties/property[@name='confluence.webapp.context.path']" -v "${contextPath}" ${configurationXml}
}
