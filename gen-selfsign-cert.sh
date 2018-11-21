#!/bin/sh

set -e

echo "### generate private key"
openssl genrsa -des3 -passout pass:dummy -out ./privkey.tmp 2048

echo "### create signing key"
openssl rsa -passin pass:dummy -in ./privkey.tmp -out ./signkey.pem

echo "### create CSR"
openssl req -new -key ./signkey.pem -out ./apache.csr -subj "/C=LU/ST=cloud/O=ACME corp./CN=localhost"

echo "### create self-signed certificate"
openssl x509 -req -days 365 -in ./apache.csr -signkey ./signkey.pem -out ./selfsign.crt

rm privkey.tmp apache.csr
