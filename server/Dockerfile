FROM softwarecraftsmen/oracle-java:8-jdk
MAINTAINER Software Craftsmen GmbH & Co KG <office@software-craftsmen.at>

ARG "version=unknown"
ARG "build_date=unknown"
ARG "commit_hash=unknown"
ARG "vcs_url=unknown"
ARG "vcs_branch=unknown"
ARG "vcs_ref=unknown"

LABEL org.label-schema.vendor="Software Craftsmen Gmbh & Co KG" \
    org.label-schema.name="Atlassian Confluence" \
    org.label-schema.description="Atlassian Confluence" \
    org.label-schema.usage="${vcs_url}" \
    org.label-schema.url="${vcs_url}" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$vcs_ref \
    org.label-schema.version=$version \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$build_date

RUN if [ ! "${http_proxy}" = "" ] ; then echo "Acquire::http::Proxy \"${http_proxy}\";" >> /etc/apt/apt.conf.d/98proxy; fi && \
    if [ ! "${https_proxy}" = "" ] ; then echo "Acquire::https::Proxy \"${https_proxy}\";" >> /etc/apt/apt.conf.d/98proxy; fi && \
    if [ ! "${http_proxy}" = "" ] ; then echo "http_proxy=${http_proxy}" >> /etc/wgetrc; fi && \
    if [ ! "${https_proxy}" = "" ] ; then echo "https_proxy=${https_proxy}" >> /etc/wgetrc; fi

ARG CONFLUENCE_VERSION=6.3.2

RUN wget --no-verbose https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin -O atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin && \
    chmod a+x atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin

# Run the installer
# The response file is produced by an attended installation at /opt/atlassian/confluence/.install4j/response.varfile
COPY response.varfile response.varfile
# Run unattended installation with input from response.varfile
RUN ./atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin -q -varfile response.varfile && \
    rm atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends gettext xmlstarlet && \
    rm -rf /var/lib/apt/lists/*
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY configure-tomcat.sh configure-tomcat.sh

RUN chmod +x docker-entrypoint.sh configure-tomcat.sh

# HTTP port
EXPOSE 8090
# Control port
EXPOSE 8000

ENTRYPOINT /docker-entrypoint.sh
