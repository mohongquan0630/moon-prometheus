
test "Text format" {
  let reg = Registry::new()
  let c = Counter::new("http_reqs", "HTTP Requests", labels=LabelSet::new([{name: "method", value: "GET"}]))
  c.inc()
  reg.register_counter(c)
  let out = reg.to_text_format()
  assert_true!(out.contains("# TYPE http_reqs counter"))
  assert_true!(out.contains("http_reqs{method=\"GET\"} 1"))
}
