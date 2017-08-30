#!/usr/bin/env bash

ROLE_COMMAND="CREATE ROLE ${CONFLUENCE_JDBC_USER} WITH LOGIN PASSWORD '${CONFLUENCE_JDBC_PASSWORD}' VALID UNTIL 'infinity';"
DATABASE_COMMAND="CREATE DATABASE confluence WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0 OWNER=${CONFLUENCE_JDBC_USER} CONNECTION LIMIT=-1;"

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command="${ROLE_COMMAND}"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command="${DATABASE_COMMAND}"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --command="GRANT ALL PRIVILEGES ON DATABASE confluence TO ${CONFLUENCE_JDBC_USER}"
