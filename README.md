If you are loocking for a httpd24 Docker file, chain to https://github.com/itsziget/httpd24-docker-image

---

This repository contains only some snippets to investigate a TLS issue with Docker 18.09 CLI.

If the Docker registry server don't support any cipher the Docker cli 18.09 supports the connect fails with

    remote error: tls: handshake failure

---

## create the Docker image

    ./docker-build.sh

## generate a selfsigned certificate

The generated certificate will be used by the httpd24 server for https connections.

    ./gen-selfsign-cert.sh

## run the httpd24 server

The server is listening on https://localhost:4443

    ./run-httpd24.sh

## check which Docker client ciphers are supported by the server

The script tries to connect with the ciphers supported by Docker cli 18.09. It tries also to connect with two ciphers (AES256-SHA256, AES128-SHA256) which were removed in that version.

    ./cipher_check.sh

example output (with the configured httpd24 server)

```
FAIL  ECDHE-ECDSA-AES256-GCM-SHA384
  OK  ECDHE-RSA-AES256-GCM-SHA384
FAIL  ECDHE-ECDSA-AES128-GCM-SHA256
  OK  ECDHE-RSA-AES128-GCM-SHA256
FAIL  ECDHE-ECDSA-AES256-SHA384
FAIL  ECDHE-ECDSA-AES128-SHA256
  OK  ECDHE-RSA-AES256-SHA384
  OK  ECDHE-RSA-AES128-SHA
  OK  AES256-SHA256
  OK  AES128-SHA256
```

Using the same ciphers as the Docker client with a short Golang code

    go run cipher_check.go

example output (when the connection is successful)

    x509: certificate signed by unknown authority
