package cmd

import (
	"fmt"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Create a new Prometheus gauge for uptime
var uptime = prometheus.NewGauge(prometheus.GaugeOpts{
	Name: "uptime_seconds",
	Help: "The number of seconds the container has been running.",
})

func init() {
	// Register the uptime metric with Prometheus's default registry
	prometheus.MustRegister(uptime)
}

func Execute() {
	// Start a new goroutine to update the uptime metric every minute
	go func() {
		start := time.Now()
		for {
			uptime.Set(time.Since(start).Seconds())
			time.Sleep(1 * time.Second)
		}
	}()

	// Expose the /metrics endpoint for Prometheus to scrape
	http.Handle("/metrics", promhttp.Handler())

	// Start the HTTP server
	fmt.Println("Starting server on :8080")
	http.ListenAndServe(":8080", nil)
}
