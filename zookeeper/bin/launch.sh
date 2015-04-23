#!/bin/sh -e

ZOOKEEPER_DIR="/var/lib/zookeeper"
ZOOKEEPER_LOG="/var/log/zookeeper/zookeeper.log"

# Chown existing state in case UID has changed in image rebuild
chown -R zookeeper:zookeeper "$ZOOKEEPER_DIR"

# Fixup configuration
if [ "$ZK_SERVERS" == "" ]; then
  echo "Missing \$ZK_SERVERS with list of peers, e.g. '\$ZK_SERVERS=server.1=1.1.1.1:2888:3888,server.2=2.2.2.2:2888:3888,server.3=3.3.3.3:2888:3888'"
  exit 1
fi

if [ "$ZK_MYID" == "" ]; then
  echo "Missing \$ZK_MYID with id of this peer, e.g. '\$ZK_MYID=1'"
  exit 1
fi

echo >> /etc/zookeeper/conf/zoo.cfg
IFS=',' ;for server in $ZK_SERVERS; do
  echo "$server" >> /etc/zookeeper/conf/zoo.cfg
done

if [ "$ZK_CLIENTPORT" != "" ]; then
  echo "clientPort=$ZK_CLIENTPORT" >> /etc/zookeeper/conf/zoo.cfg
fi

# Delete state if myid has changed
if [ ! -e "${ZOOKEEPER_DIR}/myid" ] || [ "`cat \"${ZOOKEEPER_DIR}/myid\"`" != "$ZK_MYID" ]; then
	rm -rf "${ZOOKEEPER_DIR}/*"
	service zookeeper-server init "--myid=$ZK_MYID"
fi

exec zookeeper-server start-foreground
