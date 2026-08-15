///|
test "registry exposes sorted names and supports removal" {
  let registry = Registry::new()
  registry.register_gauge(Gauge::new("z_last", "last"))
  registry.register_counter(Counter::new("a_first", "first"))
  let names = registry.metric_names()
  assert_eq(names.length(), 2)
  assert_eq(names[0], "a_first")
  assert_eq(names[1], "z_last")
  assert_true(registry.remove("a_first"))
  assert_false(registry.remove("missing"))
  assert_eq(registry.len(), 1)
}

///|
test "registry checked registration rejects invalid metric names" {
  let registry = Registry::new()
  assert_false(
    registry.register_counter_if_valid(Counter::new("2xx", "invalid")),
  )
  assert_true(
    registry.register_gauge_if_valid(Gauge::new("active_users", "valid")),
  )
  assert_eq(registry.len(), 1)
}

///|
test "label escaping covers every exposition control character" {
  let labels = LabelSet::from_pairs([("message", "a\nb\"c\\d")])
  assert_eq(labels.to_string(), "{message=\"a\\nb\\\"c\\\\d\"}")
}

///|
test "label sets can be audited before registration" {
  let valid = LabelSet::from_pairs([("method", "GET"), ("status", "200")])
  let invalid = LabelSet::new([{ name: "bad-name", value: "x" }])
  assert_true(valid.is_valid())
  assert_false(invalid.is_valid())
  let names = valid.names()
  assert_eq(names.length(), 2)
  assert_eq(names[0], "method")
  assert_eq(names[1], "status")
}

///|
test "empty summaries expose only aggregate fields" {
  let registry = Registry::new()
  registry.register_summary(Summary::new("empty_jobs", "Empty jobs"))
  let output = registry.to_text_format()
  assert_false(output.contains("quantile="))
  assert_true(output.contains("empty_jobs_count 0"))
}

///|
test "histogram cumulative count saturates at plus infinity" {
  let histogram = Histogram::new("bytes", "Observed bytes", buckets=[1.0, 2.0])
  histogram.observe(0.5)
  histogram.observe(5.0)
  assert_eq(histogram.cumulative_bucket_count(-1), 0.0)
  assert_eq(histogram.cumulative_bucket_count(99), 2.0)
}

///|
test "benchmark report includes all deterministic cases" {
  let cases = run_metric_benchmark_suite()
  let report = benchmark_report_csv(cases)
  assert_true(report.contains("counter-registry"))
  assert_true(report.contains("histogram-latency"))
  assert_true(report.contains("summary-jobs"))
}
