FROM postgres:9.6

ARG "version=unknown"
ARG "build_date=unknown"
ARG "commit_hash=unknown"
ARG "vcs_url=unknown"
ARG "vcs_branch=unknown"
ARG "vcs_ref=unknown"

LABEL org.label-schema.vendor="Software Craftsmen Gmbh & Co KG" \
    org.label-schema.name="jenkins-master" \
    org.label-schema.description="Jenkins Master" \
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

ADD initdb.sh /docker-entrypoint-initdb.d/initdb.sh
RUN chmod +x /docker-entrypoint-initdb.d/initdb.sh
