///|
test "Text format" {
  let reg = Registry::new()
  let c = Counter::new(
    "http_reqs",
    "HTTP Requests",
    labels=LabelSet::new([{ name: "method", value: "GET" }]),
  )
  c.inc()
  reg.register_counter(c)
  let out = reg.to_text_format()
  assert_true(out.contains("# TYPE http_reqs counter"))
  assert_true(out.contains("http_reqs{method=\"GET\"} 1"))
}

///|
test "Histogram text format keeps metric labels on buckets and totals" {
  let reg = Registry::new()
  let labels = LabelSet::new([{ name: "route", value: "/api" }])
  let h = Histogram::new(
    "http_request_duration_seconds",
    "HTTP latency",
    labels~,
  )
  h.observe(0.2)
  h.observe(2.0)
  reg.register_histogram(h)
  let out = reg.to_text_format()
  assert_true(
    out.contains(
      "http_request_duration_seconds_bucket{route=\"/api\",le=\"0.5\"} 1",
    ),
  )
  assert_true(
    out.contains(
      "http_request_duration_seconds_bucket{route=\"/api\",le=\"+Inf\"} 2",
    ),
  )
  assert_true(
    out.contains("http_request_duration_seconds_sum{route=\"/api\"} 2.2"),
  )
  assert_true(
    out.contains("http_request_duration_seconds_count{route=\"/api\"} 2"),
  )
}

///|
test "Registry reports registered metric names" {
  let reg = Registry::new()
  assert_true(reg.is_empty())
  let c = Counter::new("jobs_total", "Jobs")
  reg.register_counter(c)
  assert_eq(reg.len(), 1)
  assert_true(reg.contains("jobs_total"))
  assert_false(reg.contains("missing_total"))
}
