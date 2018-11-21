#!/bin/sh

# remove the container and image from previous Docker build
docker stop suboptimal-httpd24
docker rm suboptimal-httpd24
docker rmi suboptimal/httpd24

docker build -t suboptimal/httpd24 .
