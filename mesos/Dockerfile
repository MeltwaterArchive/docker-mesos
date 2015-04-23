FROM centos:6

# Install JRE
RUN yum -y install java-1.8.0-openjdk-headless && yum clean all

# Install ZooKeeper
RUN rpm -i "http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm"
RUN yum -y install zookeeper-3.4.5+28 && yum clean all

# Install Mesos and remove some unneeded static libs
RUN rpm -i "http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm"

# Note that Mesos 0.22.0 doesn't work inside a Docker container because /proc/<task-pid> doesn't
# exist inside the Mesos slave container. Mesos 0.21.1 works, however cpu/mem usage isn't collected.
RUN yum -y install mesos-0.21.1 && yum clean all && \
	rm -f /usr/local/lib/libmesos.a /usr/local/lib/libmesos.la

# Volumes for logs and cluster state
VOLUME ["/var/lib/mesos", "/var/log/mesos"]
ENV MESOS_WORK_DIR /var/lib/mesos
ENV MESOS_LOG_DIR /var/log/mesos
