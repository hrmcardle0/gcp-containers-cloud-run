// +build sidecar

package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "time"
)

func main() {
    for {
        resp, err := http.Get("http://main-container:8080/metrics")
        if err != nil {
            log.Printf("Error fetching metrics: %v\n", err)
        } else {
            body, _ := ioutil.ReadAll(resp.Body)
            fmt.Println("Metrics:\n", string(body))
            resp.Body.Close()
        }

        // Sleep for 5 seconds before fetching again
        time.Sleep(5 * time.Second)
    }
}
