///|
test "Counter logic" {
  let c = Counter::new("test_req", "Test requests")
  c.inc()
  c.add(2.0)
  assert_eq(c.value, 3.0)
}

///|
test "Gauge logic" {
  let g = Gauge::new("test_mem", "Test memory")
  g.set(100.0)
  g.inc()
  g.dec()
  g.add(7.0)
  g.sub(7.0)
  assert_eq(g.value, 100.0)
}

///|
test "Histogram and summary expose aggregate values" {
  let h = Histogram::new("request_seconds", "Request seconds")
  h.observe(0.05)
  h.observe(0.7)
  h.observe(30.0)
  assert_eq(h.count(), 3.0)
  assert_eq(h.bucket_count(0), 1.0)
  assert_eq(h.bucket_count(2), 1.0)
  assert_eq(h.bucket_count(5), 1.0)
  let s = Summary::new("job_seconds", "Job seconds")
  s.observe(2.0)
  s.observe(4.0)
  assert_eq(s.count(), 2.0)
  assert_eq(s.mean(), 3.0)
}
