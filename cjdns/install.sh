#!/bin/sh
	${INSTALL_DIR} ${1}/usr/sbin
	${INSTALL_BIN} ${PKG_BUILD_DIR}/cjdroute   ${1}/usr/sbin/cjdroute
	${INSTALL_DIR} ${1}/etc/init.d
	if [ "${CONFIG_CJDNS_INIT_PROCD}" = "y" ]
	then		
		${INSTALL_BIN} ./files/cjdns_init-procd 	${1}/etc/init.d/cjdns
	else
		${INSTALL_BIN} ./files/cjdns_init-oldstyle 	${1}/etc/init.d/cjdns		
	fi

