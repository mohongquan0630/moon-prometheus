# moon-prometheus

`moon-prometheus` is a MoonBit Prometheus metrics client for service instrumentation, CLI tooling, batch jobs, and edge workloads. It provides metric types, multidimensional labels, a registry, text exposition output, PushGateway payload helpers, process collector placeholders, and a runnable demo.

This repository is prepared for MoonBit OSC2026 acceptance. It is public, Apache-2.0 licensed, tested with MoonBit, and includes CI plus generated public API information.

## Features

- **Standard Metrics Types**:
  - `Counter`: A monotonically increasing cumulative metric (e.g., total requests, errors).
  - `Gauge`: A single numerical value that can arbitrarily go up and down (e.g., memory usage, concurrent connections).
  - `Histogram`: Samples observations (e.g., request durations) and counts them in configurable buckets.
  - `Summary`: Tracks the distribution of sliding-window quantiles.
- **Metric Registry**: Central registry for metrics registration and text exposition.
- **Multidimensional Labels**: Supports tagging metrics with key-value labels for multi-dimensional analysis.
- **OpenMetrics Serializer**: High-performance serialization into the standard Prometheus text exposition format.
- **Ecosystem Integrations**:
  - **Crescent Middleware Notes**: Adapter notes for the `bobzhang/crescent` HTTP framework.
  - **PushGateway Exporter**: Construct payloads to push metrics for ephemeral or batch jobs.
  - **ProcessCollector**: Default system metric collectors (CPU, memory size) to monitor application process status.

## Installation

Add the package to your MoonBit project:

```sh
moon add mohongquan0630/moon-prometheus
```

## Usage

```moonbit
let registry = Registry::new()

let counter = Counter::new("http_requests_total", "Total number of HTTP requests")
counter.add(3.0)
registry.register_counter(counter)

let gauge = Gauge::new("memory_usage_bytes", "Current memory usage")
gauge.set(1024.0)
registry.register_gauge(gauge)

println(registry.to_text_format())
```

Run the included demo:

```sh
moon run cmd/main
```

## Development and Testing

Verify the codebase:

```sh
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon info
```

The GitHub Actions workflow also runs the checks on Linux, macOS, and Windows. It installs the latest MoonBit toolchain and checks all supported targets in CI.

## Acceptance Notes

- Public repository: <https://gitlink.org.cn/mohongquan0630/moon-prometheus>
- Package name: `mohongquan0630/moon-prometheus`
- License: Apache-2.0
- CI: `.github/workflows/test.yml`
- Publish workflow: `.github/workflows/publish.yml`
- Generated API: `src/prometheus/pkg.generated.mbti`
- Runnable example: `moon run cmd/main`

## Source Statement

The implementation is original MoonBit code for this repository. API names and text exposition concepts follow the public Prometheus/OpenMetrics model, but no third-party source code is copied into this project.

## Current Scope

This package focuses on deterministic metric construction and exposition. It does not yet perform direct HTTP serving, background collection, or OS-specific process probing; those are extension points for framework adapters and runtime-specific packages.

## Release Checklist

```sh
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon info
git diff --exit-code
```

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
