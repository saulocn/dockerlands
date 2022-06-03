FROM openjdk:17-alpine

ARG ARTEMIS_VERSION=2.22.0
ARG ARTEMIS_SHA1=25409b33c0065eeef9ed24fa1974223767676fef


ENV ARTEMIS_VERSION $ARTEMIS_VERSION
ENV ARTEMIS_SHA1 $ARTEMIS_SHA1

RUN mkdir /artemis

WORKDIR /artemis

RUN cat /proc/version

RUN apk update && apk upgrade

RUN apk --no-cach add libaio curl

RUN curl -O https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/${ARTEMIS_VERSION}/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz 
RUN sha1sum apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz | grep ${ARTEMIS_SHA1} 
RUN mv apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz artemis.tar.gz
RUN tar -xf ./artemis.tar.gz
RUN ln -s /artemis/apache-artemis-${ARTEMIS_VERSION}/ ./current

COPY artemis.sh artemis.sh

RUN ls 
RUN pwd

RUN chmod 337 artemis.sh

# Web Server
EXPOSE 8161 \
    # JMX Exporter
    9404 \
    # CORE,MQTT,AMQP,HORNETQ,STOMP,OPENWIRE
    61616 \
    # HORNETQ,STOMP
    5445 \
    # AMQP
    5672 \
    # MQTT
    1883 \
    #STOMP
    61613

CMD [ "/bin/sh", "/artemis/artemis.sh" ]