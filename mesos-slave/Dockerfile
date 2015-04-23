FROM meltwater/mesos:latest

# Only docker containerizer is support when running Mesos inside Docker
ENV MESOS_CONTAINERIZERS docker

# Startup timeout in milliseconds since large Docker images takes a long time to pull
ENV MESOS_EXECUTOR_REGISTRATION_TIMEOUT 5mins

EXPOSE 5051
ENTRYPOINT ["mesos-slave"]
