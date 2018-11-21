#!/bin/sh

docker stop suboptimal-httpd24
docker rm suboptimal-httpd24

# http
# docker run \
#  -p 8080:80 \
#  --name "suboptimal-httpd24" \
#  suboptimal/httpd24

# https
docker run \
  -p 4443:443 \
  --env SRV_SSL=1 \
  --volume $(pwd)/signkey.pem:/usr/local/apache2/ssl.key \
  --volume $(pwd)/selfsign.crt:/usr/local/apache2/ssl.crt \
  --name "suboptimal-httpd24" \
  suboptimal/httpd24
