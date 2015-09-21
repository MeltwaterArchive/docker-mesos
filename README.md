# Dockerized Mesos Stack
These images can be used to quickly get up and running with a local [Apache Mesos](http://mesos.apache.org/), [Marathon](https://mesosphere.github.io/marathon/) 
and [Chronos](https://github.com/mesos/chronos/) cluster. The typical use case would be as a workbench to develop, test and demo your Marathon and Docker configurations.

## Usage
A local instance of the cluster infrastructure can be brought up with [Docker Compose](http://docs.docker.com/compose/) as

```
git clone git@github.com:meltwater/docker-mesos.git
cd docker-mesos

# You need to edit docker-compose.yml and set MESOS_HOSTNAME=<your IP-address> 
# on the mesosslave container. This applies if your host doesn't have a 
# hostname that resolves via DNS.

docker-compose up
```

### Modifying Services

If you add or modify the Marathon json files in marathon-submit/json/ you can restart the cluster to have them submitted. 

```
docker-compose kill
docker-compose rm -f
docker-compose build
docker-compose up
```

## Web Interfaces
**Note:** when using Mac OSX or Windows and [boot2docker](http://boot2docker.io/) the *localhost* part needs to be replaced with the hostname or IP of the boot2docker VM.

 * Mesos is available at [localhost:5050](http://localhost:5050)
 * Marathon is at [localhost:8080](http://localhost:8080)
 * Chronos is at [localhost:4400](http://localhost:4400)
 * The demo webapp can be accessed through the service discovery proxy at [localhost:1234](http://localhost:1234)
 * Using Nginx vhost the demo webapp is also at [webapp.demo.localdomain](http://webapp.demo.localdomain) if you add a host alias "127.0.0.1 webapp.demo.localdomain"

## Services and Apps
The *marathon-submit/json/* directory contains a number of example services that will be automatically submitted to Marathon on startup. You can add services by dropping JSON config files for Marathon into the *marathon-submit/json/* directory, doing a *docker-compose build* and they'll be deployed when you restart the cluster. One can also deploy apps directly to the running cluster using the Marathon [REST API](https://mesosphere.github.io/marathon/docs/rest-api.html). The same works for the *chronos-submit/json/* directory. See the Chronos [REST API](https://mesos.github.io/chronos/docs/api.html) for more info.

* [Marathon docs](https://mesosphere.github.io/marathon/docs/) for further info and examples. 
* [Chronos docs](https://mesos.github.io/chronos/docs/) for further info and examples. 

## Service Discovery
There's several ways to implement service discovery, ranging from dynamic DNS and configuration updates to lower level network 
plumbing. One of the goals of service discovery is to externalize concerns like network configuration, high availability and 
scaling from service consumers and applications. Another aspect is the ability to vary the service discovery mechanism and 
network plumbing without impacting existing applications and configurations.

### Dynamic Proxies
A common service discovery implementation involves proxies that bind to localhost and forwards TCP and UDP connections to 
where services are currently running. Clients are statically configured to access services through localhost on a 
well-known port number. The proxy takes care of failover and load balancing in case the service moves or has multiple 
replicas. In case of a failover the service consumer will receive a transient connection error and needs to retry 
until the connection reestablishes.

In this solution Marathon keeps track of running services and expose this state through RESTful HTTP endpoints. The 
[proxymatic](https://github.com/meltwater/docker-proxymatic) container subscribes to state updates and 
configures [Pen](http://siag.nu/pen/) or [HAProxy](http://www.haproxy.org/) to forward connections. The effect is 
that TCP and UDP connections are forwarded from a well known [service port](http://mesosphere.com/docs/getting-started/service-discovery/) 
to one of the healthy service replicas.
