# Kafka on Kubernetes
[![Docker Repository on Quay](https://quay.io/repository/ukhomeofficedigital/kafka/status "Docker Repository on Quay")](https://quay.io/repository/ukhomeofficedigital/kafka)

Bits you need to run Kafka cluster on Kubernetes. It is based on Kafka
version 0.9.x.

Kafka requires access to a zookeeper cluster. We run zookeeper in Kubernetes
too, take a look here: https://github.com/UKHomeOffice/docker-zookeeper.


### Configuration
* `ZOOKEEPER_CONNECT` - a comma separated list of zookeeper `node:port` pairs.
  Default: `localhost:2181`.
* `BROKER_ID` - Kafka broker.id. Default: `unset`. If unset, Kafka will get
  zookeeper to allocate one.
* `ADVERTISED_HOSTNAME` - what address to advertise to other brokers and
  producers/consumers. Default: `unset`. If `unset`, Kafka uses the hostname.
* `NUM_PARTITIONS` - Number of partitions by default. Default: `1`.
* `DEFAULT_REPLICATION_FACTOR` - Default replication factor. Default: `unset`.


### Deployment
By default, if you don't specify any parameters, kafka will start in
a single broker mode.

Deploying onto a Kubernetes cluster is fairly easy. There are example
kubernetes controller and service files in [kube/](kube/) directory.


#### Deploy Services
There is no strict ordering how you deploy the resources, let's start with
services first:

```bash
$ kubectl create -f kube/kafka-service.yaml
$ kubectl create -f kube/kafka-1-service.yaml
$ kubectl create -f kube/kafka-2-service.yaml
$ kubectl create -f kube/kafka-3-service.yaml
```


#### Deploy Replication Controllers

```
$ kubectl create -f kube/kafka-1-controller.yaml
$ kubectl create -f kube/kafka-2-controller.yaml
$ kubectl create -f kube/kafka-3-controller.yaml
```


### Known Caveats

By default there is no data persistence. So be aware that if you delete more
than one replication controller or more than one pod, you may end up losing
data.
