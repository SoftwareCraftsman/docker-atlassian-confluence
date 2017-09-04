#!/usr/bin/env bash
set -x

# Adjust this path if the installation location has been modified by the response.varfile
exec /opt/atlassian/confluence/bin/start-confluence.sh -fg
