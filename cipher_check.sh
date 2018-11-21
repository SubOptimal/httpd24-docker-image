#!/bin/sh

# docker 18.09
# Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (0xc02c) ECDHE-ECDSA-AES256-GCM-SHA384
# Cipher Suite: TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (0xc030)   ECDHE-RSA-AES256-GCM-SHA384
# Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (0xc02b) ECDHE-ECDSA-AES128-GCM-SHA256
# Cipher Suite: TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (0xc02f)   ECDHE-RSA-AES128-GCM-SHA256
# Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (0xc00a)    ECDHE-ECDSA-AES256-SHA384
# Cipher Suite: TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (0xc009)    ECDHE-ECDSA-AES128-SHA256
# Cipher Suite: TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (0xc014)      ECDHE-RSA-AES256-SHA384
# Cipher Suite: TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (0xc013)      ECDHE-RSA-AES128-SHA

# docker 18.06
# Cipher Suite: TLS_RSA_WITH_AES_256_CBC_SHA (0x0035)            AES256-SHA256
# Cipher Suite: TLS_RSA_WITH_AES_128_CBC_SHA (0x002f)            AES128-SHA256

host=localhost
port=4443

for cipher in ECDHE-ECDSA-AES256-GCM-SHA384 \
              ECDHE-RSA-AES256-GCM-SHA384 \
              ECDHE-ECDSA-AES128-GCM-SHA256 \
              ECDHE-RSA-AES128-GCM-SHA256 \
              ECDHE-ECDSA-AES256-SHA384 \
              ECDHE-ECDSA-AES128-SHA256 \
              ECDHE-RSA-AES256-SHA384 \
              ECDHE-RSA-AES128-SHA \
              AES256-SHA256 \
              AES128-SHA256
do
  openssl s_client -msg -debug -connect ${host}:${port} -cipher $cipher -tls1_2 < /dev/null > /dev/null 2>&1
  rc=$?
  if [ $rc -eq 0 ]
  then
    supported=OK
  else
    supported=FAIL
  fi
  printf "%4s  %s\n" "$supported" "$cipher"
done
