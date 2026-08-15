# moon-prometheus

`moon-prometheus` is a MoonBit metrics library for service instrumentation, CLI tooling, batch jobs, and edge workloads. It provides metric types, validated multidimensional labels, a registry, Prometheus text exposition, PushGateway payload helpers, portable process samples, and deterministic benchmark fixtures.

This repository is prepared for MoonBit OSC2026 acceptance. It is public, Apache-2.0 licensed, tested with MoonBit, and includes CI plus generated public API information.

## Features

- **Standard Metrics Types**:
  - `Counter`: A monotonically increasing cumulative metric (e.g., total requests, errors).
  - `Gauge`: A single numerical value that can arbitrarily go up and down (e.g., memory usage, concurrent connections).
  - `Histogram`: Samples observations (e.g., request durations) and counts them in configurable buckets.
  - `Summary`: Stores observations in memory and exposes configured quantiles plus aggregate sum/count values.
- **Metric Registry**: Central registry for metrics registration and text exposition.
- **Multidimensional Labels**: Validates names, escapes control characters, normalizes label order, and supports lookup/merge.
- **Metric Contracts**: `MetricDescriptor` documents a metric family and checks its label set before registration.
- **Prometheus Serializer**: Emits `HELP`, `TYPE`, cumulative histogram buckets, summary quantiles, and escaped labels.
- **Ecosystem Integrations**:
  - **Crescent Middleware Notes**: Adapter notes for the `bobzhang/crescent` HTTP framework.
  - **PushGateway Exporter**: Construct payloads to push metrics for ephemeral or batch jobs.
  - **ProcessCollector**: Portable CPU, virtual-memory, and open-file-descriptor samples that the host runtime can update.
- **Deterministic Benchmark Suite**: Exercises counter, histogram, and summary workloads and reports observations, serialized bytes, and checksums.

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
moon info --target all
```

The CI workflow runs the checks on Linux, macOS, and Windows. It installs the official MoonBit toolchain, checks all supported targets, verifies generated `.mbti` files, and builds the native target with a platform compiler.

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

This package focuses on deterministic metric construction and exposition. It does not perform direct HTTP serving, network I/O, background scheduling, or OS-specific process probing. The Crescent note and ProcessCollector API are explicit integration boundaries: a host application supplies the transport and runtime samples.

## Reproducible benchmark data

The benchmark suite is a deterministic workload, not a wall-clock claim. It records exact operation counts, serialized output size, and a checksum so CI and reviewers can compare behavior across MoonBit backends without machine-dependent timing noise.

```sh
moon run cmd/main
```

## Release Checklist

```sh
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon info --target all
git diff --exit-code
```

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
