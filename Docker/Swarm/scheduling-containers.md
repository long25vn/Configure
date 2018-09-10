## Scheduling containers

### Automatic scheduling


Some configuration options result in containers being automatically scheduled on the same Swarm node to ensure that they work correctly. These are:

  + network_mode: "service:..." and network_mode: "container:..." (and net: "container:..." in the version 1 file format).

  + volumes_from

  + links

## Manual scheduling

Swarm offers a rich set of scheduling and affinity hints, enabling you to control where containers are located. They are specified via container environment variables, so you can use Compose’s environment option to set them.

```
# Schedule containers on a specific node
environment:
  - "constraint:node==node-1"

# Schedule containers on a node that has the 'storage' label set to 'ssd'
environment:
  - "constraint:storage==ssd"

# Schedule containers where the 'redis' image is already pulled
environment:
  - "affinity:image==redis"

```

[More](https://docs.docker.com/compose/swarm/#scheduling-containers)
