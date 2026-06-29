# moon-prometheus
A robust and extensible Prometheus metrics client for MoonBit.

## Installation
```
moon add developer/moon-prometheus
```

## Ecosystem Integrations

### Crescent Web Framework
`moon-prometheus` provides middleware for the `bobzhang/crescent` framework to automatically track HTTP metrics.
```moonbit
let reg = Registry::new()
app.use(metrics_middleware(reg))
app.get("/metrics", metrics_handler(reg))
```

### PushGateway Support
For serverless or batch jobs, you can format metrics for PushGateway:
```moonbit
let pg = PushGateway::new("http://localhost:9091", "batch_job")
let payload = pg.format_push_payload(registry)
// send payload via HTTP POST to pg.push_url()
```

## Usage
```moonbit
let registry = Registry::new()
let counter = Counter::new("http_requests_total", "Total number of HTTP requests")
counter.inc()
registry.register_counter(counter)

let gauge = Gauge::new("memory_usage_bytes", "Current memory usage")
gauge.set(1024.0)
registry.register_gauge(gauge)

println(registry.to_text_format())
```
