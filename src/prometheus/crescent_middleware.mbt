// Note: This requires bobzhang/crescent web framework
// pub fn metrics_middleware(registry: Registry) -> Middleware {
//   let http_requests_total = Counter::new("http_requests_total", "Total HTTP requests")
//   registry.register_counter(http_requests_total)
//   
//   return fn (ctx, next) {
//     http_requests_total.inc()
//     next(ctx)
//   }
// }

// pub fn metrics_handler(registry: Registry) -> Handler {
//   return fn (ctx) {
//     let text = registry.to_text_format()
//     ctx.response.body = text
//   }
// }
