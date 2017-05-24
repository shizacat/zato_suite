#!/bin/bash

ZATO_BASE=/opt/zato/code
ZATO_CONF=${ZATO_BASE}/conf

function start_zato {
	trap "${ZATO_BASE}/bin/zato stop ${ZATO_CONF}; exit" SIGINT SIGTERM

	rm -f ${ZATO_CONF}/pidfile

	${ZATO_BASE}/bin/zato start $ZATO_CONF --fg
}

function setup_zato {
	create_config_zato

	mkdir -p ${ZATO_CONF}
	${ZATO_BASE}/bin/zato from-config ${ZATO_BASE}/zato_pattern.config
}

function create_config_zato {
	echo "odb_type=${ODB_TYPE}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_host=${ODB_HOST}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_port=${ODB_PORT}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_user=${ODB_USER}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_db_name=${ODB_DB_NAME}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_password=${ODB_PASSWORD}" >> ${ZATO_BASE}/zato_pattern.config
	echo "postgresql_schema=${POSTGRESQL_SCHEMA}" >> ${ZATO_BASE}/zato_pattern.config

	echo "kvdb_host=${KVDB_HOST}" >> ${ZATO_BASE}/zato_pattern.config
	echo "kvdb_port=${KVDB_PORT}" >> ${ZATO_BASE}/zato_pattern.config
	echo "kvdb_password=${KVDB_PASSWORD}" >> ${ZATO_BASE}/zato_pattern.config

	echo "cluster_id=${CLUSTER_ID}" >> ${ZATO_BASE}/zato_pattern.config

	echo "store_config=False" >> ${ZATO_BASE}/zato_pattern.config
}

if [ ! -d "${ZATO_CONF}" ]; then
	setup_zato
fi

if [ ! "$(ls -A ${ZATO_CONF})" ]; then
	setup_zato
fi

start_zato