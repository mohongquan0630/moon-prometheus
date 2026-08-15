///|
/// Build a minimal Crescent application with Prometheus instrumentation.
pub fn example_app() -> @web.App {
  let registry = @metrics.Registry::new()
  let jobs = @metrics.Counter::new("jobs_total", "Completed jobs")
  jobs.inc()
  registry.register_counter(jobs)
  let app = @web.App()
  install(app, registry)
  app
}
