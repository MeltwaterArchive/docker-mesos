FROM meltwater/mesos:latest

ENV BUILD_VERSION 0.10.1

RUN yum -y install tar gzip && yum clean all
RUN curl -o /tmp/marathon.tgz "http://downloads.mesosphere.com/marathon/v${BUILD_VERSION}/marathon-${BUILD_VERSION}.tgz" && \
	tar -C / -xzf /tmp/marathon.tgz && \
	ln -s "/marathon-${BUILD_VERSION}" /marathon && \
	rm -f /tmp/marathon.tgz

EXPOSE 8080

# Default ZK path to find Mesos masters
ENV MARATHON_MASTER zk://localhost:2181/mesos

# Default ZK path to store Marathon state
ENV MARATHON_ZK zk://localhost:2181/marathon

# Startup timeout in milliseconds since large Docker images takes a long time to pull
ENV MARATHON_TASK_LAUNCH_TIMEOUT 300000

# Enable HTTP callbacks on state changes
ENV MARATHON_EVENT_SUBSCRIBER http_callback

ENTRYPOINT ["/marathon/bin/start"]
