///|
fn main {
  let registry = @prometheus.Registry::new()
  let labels = @prometheus.LabelSet::new([
    { name: "method", value: "GET" },
    { name: "route", value: "/metrics" },
  ])
  let requests = @prometheus.Counter::new(
    "http_requests_total",
    "Total HTTP requests",
    labels~,
  )
  requests.add(3.0)
  registry.register_counter(requests)
  let latency = @prometheus.Histogram::new(
    "http_request_duration_seconds",
    "HTTP request duration in seconds",
    labels~,
  )
  latency.observe(0.12)
  latency.observe(0.8)
  registry.register_histogram(latency)
  println(registry.to_text_format())
  println("# deterministic benchmark report")
  println(
    @prometheus.benchmark_report_csv(@prometheus.run_metric_benchmark_suite()),
  )
}
