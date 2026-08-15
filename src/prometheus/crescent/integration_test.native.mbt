///|
async test "middleware delegates and counts requests" {
  let registry = @metrics.Registry::new()
  let middleware = metrics_middleware(registry)
  let event = @web.Event::{
    req: @web.HttpRequest(Get, "/health", {}, raw_body=b""),
    res: @web.HttpResponse(status_code=OK),
    params: {},
  }
  let response = middleware(event, () => "ok")
  let buffer = Buffer()
  response.output(buffer)
  assert_eq(@utf8.decode(buffer.contents()), "ok")
  assert_true(registry.to_text_format().contains("http_requests_total 1"))
}

///|
async test "metrics handler returns exposition text" {
  let registry = @metrics.Registry::new()
  let gauge = @metrics.Gauge::new("queue_depth", "Current queue depth")
  gauge.set(3.0)
  registry.register_gauge(gauge)
  let response = metrics_handler(registry)(@web.Event::{
    req: @web.HttpRequest(Get, "/metrics", {}, raw_body=b""),
    res: @web.HttpResponse(status_code=OK),
    params: {},
  })
  let buffer = Buffer()
  response.output(buffer)
  let body = @utf8.decode(buffer.contents())
  assert_true(body.contains("# TYPE queue_depth gauge"))
  assert_true(body.contains("queue_depth 3"))
}

///|
test "install registers metrics route" {
  let app = example_app()
  assert_true(app.routes().to_array().contains(("GET", "/metrics")))
}
