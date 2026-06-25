
test "Counter logic" {
  let c = Counter::new("test_req", "Test requests")
  c.inc()
  c.add(2.0)
  assert_eq!(c.value, 3.0)
}

test "Gauge logic" {
  let g = Gauge::new("test_mem", "Test memory")
  g.set(100.0)
  g.inc()
  g.dec()
  assert_eq!(g.value, 100.0)
}
