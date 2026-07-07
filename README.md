# LunarMetrics (moon-prometheus)

LunarMetrics is a production-ready, industrial-strength Prometheus metrics client library for MoonBit, fully compliant with the CNCF OpenMetrics specification. It enables developers to instrument MoonBit applications (such as Web services, microservices, and CLI utilities) with key metrics for real-time monitoring and observability.

## Features

- **Standard Metrics Types**:
  - `Counter`: A monotonically increasing cumulative metric (e.g., total requests, errors).
  - `Gauge`: A single numerical value that can arbitrarily go up and down (e.g., memory usage, concurrent connections).
  - `Histogram`: Samples observations (e.g., request durations) and counts them in configurable buckets.
  - `Summary`: Tracks the distribution of sliding-window quantiles.
- **Metric Registry**: Central registry for metrics registration and thread-safe data aggregation.
- **Multidimensional Labels**: Supports tagging metrics with key-value labels for multi-dimensional analysis.
- **OpenMetrics Serializer**: High-performance serialization into the standard Prometheus text exposition format.
- **Ecosystem Integrations**:
  - **Crescent Middleware**: Out-of-the-box auto-instrumentation middleware for the `bobzhang/crescent` HTTP framework.
  - **PushGateway Exporter**: Construct payloads to push metrics for ephemeral or batch jobs.
  - **ProcessCollector**: Default system metric collectors (CPU, memory size) to monitor application process status.

## Installation

Add the package to your MoonBit project:

```sh
moon add developer/moon-prometheus
```

## Usage

```moonbit
let registry = Registry::new()

// 1. Counter
let counter = Counter::new("http_requests_total", "Total number of HTTP requests")
counter.inc()
registry.register_counter(counter)

// 2. Gauge
let gauge = Gauge::new("memory_usage_bytes", "Current memory usage")
gauge.set(1024.0)
registry.register_gauge(gauge)

// 3. Output text format
println(registry.to_text_format())
```

## Development and Testing

Verify the codebase:

```sh
moon check
```

Run unit tests:

```sh
moon test
```

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
