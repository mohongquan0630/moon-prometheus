///|
/// Crescent adapter for a Prometheus registry.
///
/// This package is native-only because Crescent depends on async socket APIs.
/// The platform-neutral metrics implementation remains in the parent package.
pub fn metrics_middleware(registry : @metrics.Registry) -> @web.Middleware {
  let requests = @metrics.Counter::new(
    "http_requests_total", "Total HTTP requests observed by moon-prometheus",
  )
  registry.register_counter(requests)
  (_event, next) => {
    requests.inc()
    next()
  }
}

///|
/// Serves the registry in Prometheus text exposition format.
pub fn metrics_handler(registry : @metrics.Registry) -> @web.HttpHandler {
  _event => {
    @web.HttpResponse::ok()
    .header("Content-Type", "text/plain; version=0.0.4; charset=utf-8")
    .body(registry.to_text_format())
    .to_responder()
  }
}

///|
/// Installs request accounting and the conventional `/metrics` route.
pub fn install(app : @web.App, registry : @metrics.Registry) -> Unit {
  app.use_middleware(metrics_middleware(registry))
  app.get_raw("/metrics", metrics_handler(registry))
}
