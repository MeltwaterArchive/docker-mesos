FROM meltwater/mesos:latest

# Install Docker client
RUN yum -y install epel-release && \
	yum -y install docker-io && \
	yum clean all

# Only docker containerizer is support when running Mesos inside Docker
ENV MESOS_CONTAINERIZERS docker

# Startup timeout in milliseconds since large Docker images takes a long time to pull
ENV MESOS_EXECUTOR_REGISTRATION_TIMEOUT 5mins

# Allow some time for graceful exit after SIGTERM (docker stop) and before SIGKILL (docker kill)
ENV MESOS_EXECUTOR_SHUTDOWN_GRACE_PERIOD 60secs
ENV MESOS_DOCKER_STOP_TIMEOUT 50secs

# Needed to run slave inside a container
ENV MESOS_ISOLATOR cgroups/cpu,cgroups/mem

EXPOSE 5051
ENTRYPOINT ["mesos-slave"]
