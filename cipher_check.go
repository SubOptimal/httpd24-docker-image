package main

import (
    "log"
    "crypto/tls"
)

func main() {
    host := "localhost"
    port := "4443"

    log.SetFlags(log.Lshortfile)

    config := &tls.Config{
        // InsecureSkipVerify: true,
        MinVersion:               tls.VersionTLS12,
        CurvePreferences:         []tls.CurveID{
            tls.CurveP384, 
            tls.CurveP256,
        },
        PreferServerCipherSuites: true,
        CipherSuites: []uint16{
            tls.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, //  (0xc02c)
            tls.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,   //  (0xc030)
            tls.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, //  (0xc02b)
            tls.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,   //  (0xc02f)
            tls.TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,    //  (0xc00a)
            tls.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,    //  (0xc009)
            tls.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,      //  (0xc014)
            tls.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,      //  (0xc013)
        },
    }

    conn, err := tls.Dial("tcp", host + ":" + port, config)
    if err != nil {
        log.Println(err)
        return
    }
    defer conn.Close()
}