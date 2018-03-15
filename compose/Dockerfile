# use the python 3 image
FROM python:3

# create a /app directory in the container file system
RUN mkdir /app

# set the directory context for future directives in the Dockerfile
WORKDIR /app

# map the local file system's requirements file into the container
# filesystem so we can use it to build our dependencies into the container
ADD requirements.txt /app/

# install dependencies
# note: this runs from the WORKDIR we setup earlier
RUN pip install -r requirements.txt

# map all code in the directory we build the container from
# on the local file system into the container file system at /app
# this will put the python source into the container to be run
ADD . /app/
