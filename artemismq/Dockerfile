FROM openjdk:11

ARG ARTEMIS_VERSION=2.18.0
ARG ARTEMIS_SHA1=3619d514a9f48547c2c36ff25a3bb5ede34b9219


ENV ARTEMIS_VERSION $ARTEMIS_VERSION
ENV ARTEMIS_SHA1 $ARTEMIS_SHA1

RUN mkdir /artemis

WORKDIR /artemis

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install libaio1

RUN curl -O https://repository.apache.org/content/repositories/releases/org/apache/activemq/apache-artemis/$ARTEMIS_VERSION/apache-artemis-$ARTEMIS_VERSION-bin.tar.gz 
RUN sha1sum apache-artemis-$ARTEMIS_VERSION-bin.tar.gz | grep $ARTEMIS_SHA1 
RUN mv apache-artemis-$ARTEMIS_VERSION-bin.tar.gz artemis.tar.gz
RUN tar -xf ./artemis.tar.gz
RUN ln -s /artemis/apache-artemis-$ARTEMIS_VERSION/ ./current

COPY artemis.sh artemis.sh

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


ENTRYPOINT /artemis/artemis.sh