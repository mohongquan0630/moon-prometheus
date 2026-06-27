# moon-prometheus
A robust and extensible Prometheus metrics client for MoonBit.

## Installation
```
moon add developer/moon-prometheus
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
