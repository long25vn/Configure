#!/bin/bash

service=myservicename; for f in $(docker service ps -q --filter desired-state=running $service); do docker inspect --format '{{.NodeID}} {{.Status.ContainerStatus.ContainerID}}' $f; done

