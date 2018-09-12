## Set service mode (--mode)
The service mode determines whether this is a replicated service or a global service. A replicated service runs as many tasks as specified, while a global service runs on each active node in the swarm.

The following command creates a global service:
```
$ docker service create \
 --name redis_2 \
 --mode global \
 redis:3.0.6
```

### Specify service constraints (--constraint)

You can limit the set of nodes where a task can be scheduled by defining constraint expressions. Multiple constraints find nodes that satisfy every expression (AND match). Constraints can match node or Docker Engine labels as follows:

| node attribute        | matches           | example  |
| ------------- |-------------|-----|
| node.id      | 	Node ID | node.id==2ivku8v2gvtg4 |
| node.hostname      | Node hostname      |   node.hostname!=node-2 |
| node.role | Node role      |    	node.role==manager |
| node.labels | user defined node labels      |    	node.labels.security==high |
| engine.labels | Docker Engine's labels      |    	engine.labels.operatingsystem==ubuntu 14.04 |

```engine.labels``` apply to Docker Engine labels like operating system, drivers, etc. Swarm administrators add node.labels for operational purposes by using the ```docker node update``` command.

For example, the following limits tasks for the redis service to nodes where the node type label equals queue:

```
$ docker service create \
  --name redis_2 \
  --constraint 'node.labels.type == queue' \
  redis:3.0.6
```

### Specify service placement preferences (--placement-pref)

You can set up the service to divide tasks evenly over different categories of nodes. One example of where this can be useful is to balance tasks over a set of datacenters or availability zones. The example below illustrates this:

```
$ docker service create \
  --replicas 9 \
  --name redis_2 \
  --placement-pref 'spread=node.labels.datacenter' \
  redis:3.0.6
``` 

This uses `--placement-pref` with a `spread` strategy (currently the only supported strategy) to spread tasks evenly over the values of the `datacenter` node label. In this example, we assume that every node has a datacenter node label attached to it. If there are three different values of this label among nodes in the swarm, one third of the tasks will be placed on the nodes associated with each value. This is true even if there are more nodes with one value than another. For example, consider the following set of nodes:

+ Three nodes with ```node.labels.datacenter=east```
+ Two nodes with `node.labels.datacenter=south`
+ One node with `node.labels.datacenter=west`

Since we are spreading over the values of the `datacenter` label and the service has 9 replicas, 3 replicas will end up in each datacenter. There are three nodes associated with the value `east`, so each one will get one of the three replicas reserved for this value. There are two nodes with the value `south`, and the three replicas for this value will be divided between them, with one receiving two replicas and another receiving just one. Finally, `west` has a single node that will get all three replicas reserved for `west`.

If the nodes in one category (for example, those with ```node.labels.datacenter=south```) can’t handle their fair share of tasks due to constraints or resource limitations, the extra tasks will be assigned to other nodes instead, if possible.

Both engine labels and node labels are supported by placement preferences. The example above uses a node label, because the label is referenced with `node.labels.datacenter`. To spread over the values of an engine label, use `--placement-pref spread=engine.labels.<labelname>`.

It is possible to add multiple placement preferences to a service. This establishes a hierarchy of preferences, so that tasks are first divided over one category, and then further divided over additional categories. One example of where this may be useful is dividing tasks fairly between datacenters, and then splitting the tasks within each datacenter over a choice of racks. To add multiple placement preferences, specify the `--placement-pref` flag multiple times. The order is significant, and the placement preferences will be applied in the order given when making scheduling decisions.

The following example sets up a service with multiple placement preferences. Tasks are spread first over the various datacenters, and then over racks (as indicated by the respective labels):
```
$ docker service create \
  --replicas 9 \
  --name redis_2 \
  --placement-pref 'spread=node.labels.datacenter' \
  --placement-pref 'spread=node.labels.rack' \
  redis:3.0.6
```

When updating a service with docker service update, --placement-pref-add appends a new placement preference after all existing placement preferences. --placement-pref-rm removes an existing placement preference that matches the argument.

### Attach a service to an existing network (--network)

You can use overlay networks to connect one or more services within the swarm.

First, create an overlay network on a manager node the docker network create command:

```
$ docker network create --driver overlay my-network
etjpu59cykrptrgw0z0hk5snf
```

After you create an overlay network in swarm mode, all manager nodes have access to the network.

When you create a service and pass the --network flag to attach the service to the overlay network:

```
$ docker service create \
  --replicas 3 \
  --network my-network \
  --name my-web \
  nginx
716thylsndqma81j6kkkb5aus
```

The swarm extends my-network to each node running the service.

Containers on the same network can access each other using service discovery.

Long form syntax of --network allows to specify list of aliases and driver options:
--network name=my-network,alias=web1,driver-opt=field1=value1

### Publish service ports externally to the swarm (-p, --publish)
You can publish service ports to make them available externally to the swarm using the --publish flag. The --publish flag can take two different styles of arguments. The short version is positional, and allows you to specify the published port and target port separated by a colon.

$ docker service create --name my_web --replicas 3 --publish 8080:80 nginx
There is also a long format, which is easier to read and allows you to specify more options. The long format is preferred. You cannot specify the service’s mode when using the short format. Here is an example of using the long format for the same service as above:

$ docker service create --name my_web --replicas 3 --publish published=8080,target=80 nginx
The options you can specify are:

Option	Short syntax	Long syntax	Description
published and target port	--publish 8080:80	--publish published=8080,target=80	
The target port within the container and the port to map it to on the nodes, using the routing mesh (ingress) or host-level networking. More options are available, later in this table. The key-value syntax is preferred, because it is somewhat self-documenting.

mode	Not possible to set using short syntax.	--publish published=8080,target=80,mode=host	
The mode to use for binding the port, either ingress or host. Defaults to ingress to use the routing mesh.

protocol	--publish 8080:80/tcp	--publish published=8080,target=80,protocol=tcp	
The protocol to use, tcp , udp, or sctp. Defaults to tcp. To bind a port for both protocols, specify the -p or --publish flag twice.

When you publish a service port using ingress mode, the swarm routing mesh makes the service accessible at the published port on every node regardless if there is a task for the service running on the node. If you use host mode, the port is only bound on nodes where the service is running, and a given port on a node can only be bound once. You can only set the publication mode using the long syntax. For more information refer to Use swarm mode routing mesh.

### Provide credential specs for managed service accounts (Windows only)
This option is only used for services using Windows containers. The --credential-spec must be in the format file://<filename> or registry://<value-name>.

When using the file://<filename> format, the referenced file must be present in the CredentialSpecs subdirectory in the docker data directory, which defaults to C:\ProgramData\Docker\ on Windows. For example, specifying file://spec.json loads C:\ProgramData\Docker\CredentialSpecs\spec.json.

When using the registry://<value-name> format, the credential spec is read from the Windows registry on the daemon’s host. The specified registry value must be located in:

HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers\CredentialSpecs

### Create services using templates
You can use templates for some flags of service create, using the syntax provided by the Go’s text/template package.

The supported flags are the following :

```
--hostname
--mount
--env
```

Valid placeholders for the Go template are listed below:

Placeholder	Description
.Service.ID	Service ID
.Service.Name	Service name
.Service.Labels	Service labels
.Node.ID	Node ID
.Node.Hostname	Node Hostname
.Task.ID	Task ID
.Task.Name	Task name
.Task.Slot	Task slot


##TEMPLATE EXAMPLE

In this example, we are going to set the template of the created containers based on the service’s name, the node’s ID and hostname where it sits.

$ docker service create --name hosttempl \
                        --hostname="{{.Node.Hostname}}-{{.Node.ID}}-{{.Service.Name}}"\
                         busybox top

va8ew30grofhjoychbr6iot8c
```
$ docker service ps va8ew30grofhjoychbr6iot8c

ID            NAME         IMAGE                                                                                   NODE          DESIRED STATE  CURRENT STATE               ERROR  PORTS
wo41w8hg8qan  hosttempl.1  busybox:latest@sha256:29f5d56d12684887bdfa50dcd29fc31eea4aaf4ad3bec43daf19026a7ce69912  2e7a8a9c4da2  Running        Running about a minute ago
```
```
$ docker inspect --format="{{.Config.Hostname}}" 2e7a8a9c4da2-wo41w8hg8qanxwjwsg4kxpprj-hosttempl

x3ti0erg11rjpg64m75kej2mz-hosttempl
```

[More](https://docs.docker.com/engine/reference/commandline/service_create/)
