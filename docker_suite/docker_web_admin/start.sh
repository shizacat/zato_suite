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

	update_password_web
	# sed -i 's/127.0.0.1/0.0.0.0/g' /opt/zato/env/web-admin/config/repo/web-admin.conf
}

function create_config_zato {
	echo "odb_type=${ODB_TYPE}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_host=${ODB_HOST}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_port=${ODB_PORT}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_user=${ODB_USER}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_db_name=${ODB_DB_NAME}" >> ${ZATO_BASE}/zato_pattern.config
	echo "odb_password=${ODB_PASSWORD}" >> ${ZATO_BASE}/zato_pattern.config
	echo "postgresql_schema=${POSTGRESQL_SCHEMA}" >> ${ZATO_BASE}/zato_pattern.config
	echo "tech_account_name=${TECH_ACCOUNT_NAME}" >> ${ZATO_BASE}/zato_pattern.config
	echo "tech_account_password=${TECH_ACCOUNT_PASSWORD}" >> ${ZATO_BASE}/zato_pattern.config

	echo "store_config=False" >> ${ZATO_BASE}/zato_pattern.config
}

function update_password_web {
	echo "command=update_password" > /tmp/up.config
	echo "path=/opt/zato/code/conf" >> /tmp/up.config
	echo "store_config=False" >> /tmp/up.config
	echo "username=admin" >> /tmp/up.config
	echo "password=${ADMIN_PASSWORD}" >> /tmp/up.config

	${ZATO_BASE}/bin/zato from-config /tmp/up.config

	rm /tmp/up.config
}

if [ ! -d "${ZATO_CONF}" ]; then
	setup_zato
fi

if [ ! "$(ls -A ${ZATO_CONF})" ]; then
	setup_zato
fi

start_zato