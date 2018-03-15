#!/usr/bin/env bash

# run a basic local postgres container
sudo docker run \
     --rm \
     --name pg \
     -e POSTGRES_PASSWORD=postgres \
     -p 5432:5432 \
     -d postgres:10

# run a postgres container for remote connections
# now you can hit the postges port remotely by binding
# the the underlying hosts network interface
sudo docker run \
     --rm \
     --name pg \
     --network host \
     -e POSTGRES_PASSWORD=postgres \
     -p 5432:5432 \
     -d postgres:10

