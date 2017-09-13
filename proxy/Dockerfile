FROM nginx:1.11
MAINTAINER Software Craftsmen GmbH und CoKG <office@software-craftsmen.at>

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

COPY nginx*.template /etc/nginx/conf.d/
COPY docker-entrypoint.sh docker-entrypoint.sh

RUN chmod +x docker-entrypoint.sh

CMD "./docker-entrypoint.sh"
