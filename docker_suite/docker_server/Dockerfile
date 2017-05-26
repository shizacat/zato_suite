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

# Redis
ENV KVDB_HOST=127.0.0.1
ENV KVDB_PORT=6379
ENV KVDB_PASSWORD=

ENV CLUSTER_NAME=
ENV SERVER_NAME=

ENV JWT_SECRET=

RUN mkdir -p /opt/zato/code/conf

COPY zato.config /opt/zato/code/zato_pattern.config
COPY start.sh /bin/start.sh

EXPOSE 17010
WORKDIR /opt/zato

ENTRYPOINT ["/bin/start.sh"]