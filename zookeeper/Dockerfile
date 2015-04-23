FROM centos:6

# Install JRE
RUN yum -y install java-1.8.0-openjdk-headless && yum clean all

# Install ZooKeeper
RUN rpm -i "http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm"
RUN yum -y install zookeeper-3.4.5+28 && yum clean all

# Install ZooKeeper server
RUN yum -y install zookeeper-server-3.4.5+28 && yum clean all

# Put ZooKeeper logs to stdout
RUN sed -i 's/log4j.rootLogger=.*/log4j.rootLogger=INFO, CONSOLE/g' /etc/zookeeper/conf/log4j.properties

# Delete cluster state snapshots automatically
RUN echo "autopurge.snapRetainCount=3" >> /etc/zookeeper/conf/zoo.cfg
RUN echo "autopurge.purgeInterval=1" >> /etc/zookeeper/conf/zoo.cfg

# Volume for ZooKeeper state
VOLUME ["/var/lib/zookeeper"]

EXPOSE 2181 2888 3888

COPY bin/launch.sh /
ENTRYPOINT ["/launch.sh"]
