FROM openjdk:21-jdk-bullseye

# Set the WILDFLY_VERSION env variable
ARG WILDFLY_VERSION=31.0.1.Final
ARG WILDFLY_SHA1=f3dc65a92698173a36fa96b082eed5521f5f8494

ENV WILDFLY_VERSION $WILDFLY_VERSION
ENV WILDFLY_SHA1 $WILDFLY_SHA1
ENV JBOSS_HOME /opt/jboss/wildfly
ENV PROFILE default

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss && \
    chmod 755 /opt/jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME && \
	curl  -LJO https://github.com/wildfly/wildfly/releases/download/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
	sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 && \
	tar xf wildfly-$WILDFLY_VERSION.tar.gz && \
	mv wildfly-$WILDFLY_VERSION $JBOSS_HOME && \
	rm wildfly-$WILDFLY_VERSION.tar.gz && \
	chown -R jboss:0 ${JBOSS_HOME} && \
	chmod -R g+rw ${JBOSS_HOME} 

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Specify the user which should be used to execute all commands below
USER jboss

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --server-config standalone-full.xml -P file:/opt/jboss/wildfly/standalone/configuration/wildfly-${PROFILE}.properties

USER root
RUN mv /etc/localtime /etc/localtime.bak \
        && ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
		&& ln -s ${JBOSS_HOME}/standalone/deployments /deployments

USER jboss

# Expose the ports we're interested in
EXPOSE 8080 8787 8443

ADD driver-module-install.cli .
ADD standalone.conf ${JBOSS_HOME}/bin/
ADD --chown=1001:0 --chmod=007 install.sh .

ENV POSTGRES_DRIVER_VERSION 42.7.2

# Download drivers.
RUN  curl -O https://jdbc.postgresql.org/download/postgresql-$POSTGRES_DRIVER_VERSION.jar

RUN ls -lha install.sh 
# Standalone.xml modifications.
RUN sed -i -e 's,POSTGRES_DRIVER_VERSION,'$POSTGRES_DRIVER_VERSION',g' driver-module-install.cli \
	&& rm -rf postgresql-$POSTGRES_DRIVER_VERSION.jar \
	&& ./install.sh driver-module-install.cli \
	&& rm driver-module-install.cli \
	&& touch /opt/jboss/wildfly/standalone/configuration/wildfly-default.properties