///|
test "metric descriptors validate label contracts" {
  let descriptor = MetricDescriptor::new(
    "http_requests_total",
    "Total requests",
    CounterType,
    ["method", "status"],
  )
  assert_true(descriptor.is_valid())
  assert_true(
    descriptor.accepts_labels(
      LabelSet::from_pairs([("status", "200"), ("method", "GET")]),
    ),
  )
  assert_false(
    descriptor.accepts_labels(LabelSet::from_pairs([("method", "GET")])),
  )
}

///|
test "metric descriptors reject malformed public names" {
  let descriptor = MetricDescriptor::new("2xx", "Invalid", GaugeType, [])
  assert_false(descriptor.is_valid())
  assert_true(descriptor.label_names().length() == 0)
}

///|
test "metric descriptor summary is stable for release notes" {
  let descriptor = MetricDescriptor::new(
    "queue_depth",
    "Current queue depth",
    GaugeType,
    ["worker"],
  )
  assert_eq(
    descriptor.summary(),
    "gauge queue_depth {worker}: Current queue depth",
  )
}
