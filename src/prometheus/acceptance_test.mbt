///|
test "labels validate names and escape exposition values" {
  assert_true(validate_metric_name("http_requests_total"))
  assert_true(validate_label_name("route_2"))
  assert_false(validate_metric_name("2xx"))
  assert_false(validate_label_name("http-method"))
  assert_eq(
    escape_label_value("line\nquote\"slash\\"),
    "line\\nquote\\\"slash\\\\",
  )
}

///|
test "label sets provide deterministic lookup and merge" {
  let base = LabelSet::from_pairs([("service", "api"), ("route", "/search")])
  let extra = LabelSet::from_pairs([("status", "200")])
  assert_true(base.contains("route"))
  match base.get("service") {
    Some(value) => assert_eq(value, "api")
    None => fail("service label was not found")
  }
  assert_true(base.get("missing") is None)
  assert_eq(base.merge(extra).length(), 3)
  assert_eq(
    base.merge(extra).to_string(),
    "{route=\"/search\",service=\"api\",status=\"200\"}",
  )
}

///|
test "histogram sorts buckets and exposes cumulative boundaries" {
  let h = Histogram::new("latency_seconds", "Request latency", buckets=[
    1.0, 0.1, 0.5, 0.5,
  ])
  let bounds = h.bucket_bounds()
  assert_eq(bounds.length(), 3)
  assert_eq(bounds[0], 0.1)
  assert_eq(bounds[1], 0.5)
  assert_eq(bounds[2], 1.0)
  h.observe(0.2)
  h.observe(2.0)
  assert_eq(h.cumulative_bucket_count(0), 0.0)
  assert_eq(h.cumulative_bucket_count(1), 1.0)
  assert_eq(h.cumulative_bucket_count(3), 2.0)
}

///|
test "summary computes configured quantiles and renders them" {
  let s = Summary::new("job_duration_seconds", "Job duration", quantiles=[
    0.5, 0.9,
  ])
  s.observe(1.0)
  s.observe(2.0)
  s.observe(4.0)
  match s.quantile(0.5) {
    Some(value) => assert_eq(value, 2.0)
    None => fail("median was not computed")
  }
  match s.quantile(0.9) {
    Some(value) => assert_eq(value, 4.0)
    None => fail("p90 was not computed")
  }
  let reg = Registry::new()
  reg.register_summary(s)
  let output = reg.to_text_format()
  assert_true(output.contains("job_duration_seconds{quantile=\"0.5\"}"))
}

///|
test "process collector accepts portable samples" {
  let reg = Registry::new()
  let collector = ProcessCollector::new(reg)
  collector.set_cpu_seconds(1.25)
  collector.set_virtual_memory_bytes(4096.0)
  collector.set_open_file_descriptors(7.0)
  collector.collect()
  let output = reg.to_text_format()
  assert_true(output.contains("process_cpu_seconds_total 1.25"))
  assert_true(output.contains("process_virtual_memory_bytes 4096"))
  assert_true(output.contains("process_open_fds 7"))
}

///|
test "push gateway escapes job and grouping path segments" {
  let pg = PushGateway::new("http://localhost:9091/", "nightly backup")
  let grouped = pg.with_grouping_labels(
    LabelSet::from_pairs([("instance", "worker/1"), ("team", "core")]),
  )
  assert_eq(
    grouped.push_url(),
    "http://localhost:9091/metrics/job/nightly%20backup/instance/worker%2F1/team/core",
  )
}

///|
test "benchmark suite returns stable workload measurements" {
  let cases = run_metric_benchmark_suite()
  assert_true(cases.length() >= 3)
  assert_true(cases[0].samples > 0)
  assert_true(cases[0].observations > 0)
  let csv = benchmark_report_csv(cases)
  assert_true(
    csv.has_prefix("name,samples,observations,serialized_bytes,checksum\n"),
  )
}
