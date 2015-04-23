# Clustering Infrastructure Images
These Docker images can be used to build an [Apache Mesos](http://mesos.apache.org/) based cluster. 

A local instance of the cluster infrastructure can be brought up with [Docker Compose](http://docs.docker.com/compose/) as

```
git clone git@github.com:meltwater/docker-mesos.git
cd docker-mesos
docker-compose build
docker-compose up
```

 * Mesos is available at [localhost:5050](http://localhost:5050)
 * Marathon at [localhost:8080](http://localhost:8080)

## Service Discovery
There's several ways to implement service discovery, ranging from dynamic DNS and configuration updates to lower level network 
plumbing. One of the goals of service discovery is to externalize concerns like network configuration, high availability and 
scaling from service consumers and applications. Another aspect is the ability to vary the service discovery mechanism and 
network plumbing without impacting existing applications and configurations.

### Network Proxies
A common service discovery implementation involves proxies that bind to localhost and forwards TCP and UDP connections to 
where the service is currently running. Clients are then statically configured to access services through localhost on a 
well-known portnumber. The proxy takes care of failover and load balancing in case the service moves or has multiple 
replicas. In case of a failover the service consumer will receive a transient network connection error and needs to retry 
until the connection reestablishes.

In this solution Marathon keeps track of running services and expose this state through RESTful HTTP endpoints. The 
[proxymatic](https://github.com/meltwater/docker-proxymatic) container subscribes to state updates and 
configures [Pen](http://siag.nu/pen/) or [HAProxy](http://www.haproxy.org/) to forward connections. The effect is 
that TCP and UDP connections are forwarded from a well known [service port](http://mesosphere.com/docs/getting-started/service-discovery/) 
to one of the healthy service replicas.
