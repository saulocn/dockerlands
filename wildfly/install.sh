#!/bin/bash

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${2:-"standalone"}
JBOSS_CONFIG=${3:-"standalone-full.xml"}

function wait_for_server() {
  until $JBOSS_CLI -c "ls /deployment" & do
    sleep 1
  done
}

echo "=> Starting WildFly server - Config file="$JBOSS_CONFIG
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Executing the commands"
$JBOSS_CLI -c --file=$1

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi

rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history