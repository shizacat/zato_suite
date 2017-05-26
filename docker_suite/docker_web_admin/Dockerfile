# Zato web-admin image

FROM shizacat/zato_base
MAINTAINER ShizaCat <...@zato.io>

RUN set -a

ENV ODB_TYPE=postgresql
ENV ODB_HOST=
ENV ODB_PORT=5432 
ENV ODB_USER=
ENV ODB_DB_NAME=
ENV ODB_PASSWORD=

ENV POSTGRESQL_SCHEMA=

ENV TECH_ACCOUNT_NAME=
ENV TECH_ACCOUNT_PASSWORD=

ENV ADMIN_PASSWORD=

RUN mkdir -p /opt/zato/code/conf

COPY zato.config /opt/zato/code/zato_pattern.config
COPY start.sh /bin/start.sh

EXPOSE 8183
WORKDIR /opt/zato

ENTRYPOINT ["/bin/start.sh"]