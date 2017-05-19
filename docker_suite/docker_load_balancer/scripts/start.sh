#!/bin/bash

ZATO_BASE=/opt/zato/code
ZATO_CONF=${ZATO_BASE}/conf

function start_zato {
	trap "${ZATO_BASE}/bin/zato stop ${ZATO_CONF}; exit" SIGINT SIGTERM

	rm -f ${ZATO_CONF}/zato-lb-agent.pid
	rm -f ${ZATO_CONF}/pidfile

	${ZATO_BASE}/bin/zato start $ZATO_CONF --fg
}

function setup_zato {
	mkdir -p ${ZATO_CONF}
	${ZATO_BASE}/bin/zato from-config ${ZATO_BASE}/zato_pattern.config

	sed -i 's/127.0.0.1:11223/0.0.0.0:11223/g' ${ZATO_CONF}/config/repo/zato.config
	sed -i 's/localhost/0.0.0.0/g' ${ZATO_CONF}/config/repo/lb-agent.conf
}

if [ ! -d "${ZATO_CONF}" ]; then
	setup_zato
fi

if [ ! "$(ls -A ${ZATO_CONF})" ]; then
	setup_zato
fi

start_zato