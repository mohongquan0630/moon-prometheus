///|
pub struct MetricBenchmarkCase {
  name : String
  samples : Int
  observations : Int
  serialized_bytes : Int
  checksum : Double
} derive(Debug, ToJson)

///|
pub fn MetricBenchmarkCase::name(self : MetricBenchmarkCase) -> String {
  self.name
}

///|
pub fn MetricBenchmarkCase::samples(self : MetricBenchmarkCase) -> Int {
  self.samples
}

///|
pub fn MetricBenchmarkCase::observations(self : MetricBenchmarkCase) -> Int {
  self.observations
}

///|
pub fn MetricBenchmarkCase::serialized_bytes(self : MetricBenchmarkCase) -> Int {
  self.serialized_bytes
}

///|
pub fn MetricBenchmarkCase::checksum(self : MetricBenchmarkCase) -> Double {
  self.checksum
}

///|
fn benchmark_counter_case() -> MetricBenchmarkCase {
  let registry = Registry::new()
  let counter = Counter::new("benchmark_events_total", "Benchmark event count")
  for i in 0..<1000 {
    counter.add((i % 7).to_double())
  }
  registry.register_counter(counter)
  let output = registry.to_text_format()
  {
    name: "counter-registry",
    samples: 1000,
    observations: 2997,
    serialized_bytes: output.length(),
    checksum: 2997.0,
  }
}

///|
fn benchmark_histogram_case() -> MetricBenchmarkCase {
  let registry = Registry::new()
  let histogram = Histogram::new(
    "benchmark_latency_seconds",
    "Deterministic latency fixture",
    buckets=[0.001, 0.005, 0.01, 0.05, 0.1, 1.0],
  )
  for i in 0..<512 {
    histogram.observe((i % 20).to_double() / 1000.0)
  }
  registry.register_histogram(histogram)
  let output = registry.to_text_format()
  {
    name: "histogram-latency",
    samples: 512,
    observations: 512,
    serialized_bytes: output.length(),
    checksum: histogram.sum(),
  }
}

///|
fn benchmark_summary_case() -> MetricBenchmarkCase {
  let registry = Registry::new()
  let summary = Summary::new(
    "benchmark_jobs_seconds", "Deterministic job fixture",
  )
  for i in 1..<=256 {
    summary.observe((i % 32).to_double() / 100.0)
  }
  registry.register_summary(summary)
  let output = registry.to_text_format()
  {
    name: "summary-jobs",
    samples: 256,
    observations: 256,
    serialized_bytes: output.length(),
    checksum: summary.mean(),
  }
}

///|
pub fn run_metric_benchmark_suite() -> Array[MetricBenchmarkCase] {
  [
    benchmark_counter_case(),
    benchmark_histogram_case(),
    benchmark_summary_case(),
  ]
}

///|
pub fn benchmark_report_csv(cases : ArrayView[MetricBenchmarkCase]) -> String {
  let out = StringBuilder::new()
  out.write_string("name,samples,observations,serialized_bytes,checksum\n")
  for sample in cases {
    out.write_string(
      "\{sample.name()},\{sample.samples()},\{sample.observations()},\{sample.serialized_bytes()},\{sample.checksum()}\n",
    )
  }
  out.to_string()
}
