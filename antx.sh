#!/bin/bash

APPLICATION_NAME=springboot-antx-demo
VERSION=1.0
ZIP_NAME=${APPLICATION_NAME}-assembly-${VERSION}-deploy.zip
DEST_PATH=/tmp

rm -rf ${DEST_PATH}/*

UNZIP ./assembly/target/${ZIP_NAME} -d ${DEST_PATH}/

echo "BUILD JAR..."
antx=${DEST_PATH}/${APPLICATION_NAME}-assembly-${VERSION}/antx.properties

echo \
"
loggerRoot = /tmp/logs
loggerAppName = ${APPLICATION_NAME}
logPattern=%d{yyyy-MM-dd HH:mm:ss.SSS} [${APPLICATION_NAME},%X{X-B3-TraceId},%X{X-B3-SpanId},%thread] [%-5level] [%logger{10}] %msg%n
logLevel=DEBUG
" \
>> ${antx}

echo "server.config.uri=http://0.0.0.0:8888" >> ${antx}
echo "server.config.label=develop" >> ${antx}

cat ${antx}

./autoconfig -u ${antx} ${DEST_PATH}/${APPLICATION_NAME}-assembly-${VERSION}/core/*.jar
