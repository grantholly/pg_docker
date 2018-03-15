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

# now let's add some persistence for our data so we
# don't lose any state if the container dies.  We will
# create a directory "data" to hold the postgres WAL,
# data, logs, config files, and data
mkdir $HOME/github/pg_docker/data

sudo docker run \
     --rm \
     --name pg \
     --network host \
     -v $HOME/github/pg_docker/data:/var/lib/postgresql/data/pgdata \
     -e PGDATA=/var/lib/postgresql/data/pgdata \
     -e POSTGRES_PASSWORD=postgres \
     -p 5432:5432 \
     -d postgres:10

# the container has no data in it when we pull or build it
# we can add further database initialization and boot strapping
# to our container workflow by using the docker-entrypoint-initdb.d
sudo docker run \
     --rm \
     --name pg \
     --network host \
     -v $HOME/github/pg_docker/init:/docker-entrypoint-initdb.d \
     -v $HOME/github/pg_docker/data:/var/lib/postgresql/data/pgdata \
     -e PGDATA=/var/lib/postgresql/data/pgdata \
     -e POSTGRES_PASSWORD=postgres \
     -p 5432:5432 \
     -d postgres:10

