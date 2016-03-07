#!/bin/bash

CONFIG_FILE='/kafka/config/server.properties'


: ${ZOOKEEPER_CONNECT:=localhost:2181}
: ${NUM_PARTITIONS:=1}


if [[ -n ${BROKER_ID} ]]; then
  echo "broker.id=${BROKER_ID}" >> ${CONFIG_FILE}
fi

if [[ -n ${ADVERTISED_HOSTNAME} ]]; then
  echo "advertised.host.name=${ADVERTISED_HOSTNAME}" >> ${CONFIG_FILE}
fi

if [[ -n ${DEFAULT_REPLICATION_FACTOR} ]]; then
  echo "default.replication.factor=${DEFAULT_REPLICATION_FACTOR}" >> ${CONFIG_FILE}
fi

sed -e "s/%ZOOKEEPER_CONNECT%/${ZOOKEEPER_CONNECT}/" -i ${CONFIG_FILE}
sed -e "s/%NUM_PARTITIONS%/${NUM_PARTITIONS}/" -i ${CONFIG_FILE}

exec /kafka/bin/kafka-server-start.sh ${CONFIG_FILE}
