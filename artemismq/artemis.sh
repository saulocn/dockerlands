#!/bin/bash
/artemis/current/bin/artemis create --user ${ARTEMIS_USER} --password ${ARTEMIS_PASSWORD} --http-host 0.0.0.0 --require-login --relax-jolokia ${ARTEMIS_BROKER}
cp /artemis/etc/broker.xml /artemis/${ARTEMIS_BROKER}/etc/broker.xml
/artemis/${ARTEMIS_BROKER}/bin/artemis run