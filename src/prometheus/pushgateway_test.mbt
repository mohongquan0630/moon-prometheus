///|
test "PushGateway URL format" {
  let pg = PushGateway::new("http://localhost:9091", "my_batch_job")
  assert_eq(pg.push_url(), "http://localhost:9091/metrics/job/my_batch_job")
}
