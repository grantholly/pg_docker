#!/usr/bin/env bash

# create a small application stack with docker-compose
# we will have a basic web app talk to postgres and both
# processes will live in containers

# first up we need a Dockerfile

# next we will need a docker-compose.yml file to describe the
# application stack in terms of which images we are using
# how we configure those images and the wiring of the multi
# container environment

# create a requirements.txt file for our Python project

# create the project scaffolding on the local file system to be
# mapped into the container file system
sudo docker-compose \
     run \
     app \
     django-admin.py \
     startproject \
     hellopostgres \
     .

# because the last command ran in the python container the root user
# owns those files so we need to fix that
sudo chown -R $USER:$USER .

# now we can edit the project config files to wire it up to postgres

# time to launch the multi container app stack with postgres
sudo docker-compose up -d

# now check localhost:8000 in a browser
