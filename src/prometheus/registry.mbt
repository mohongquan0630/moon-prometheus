
enum Metric {
  MCounter(Counter)
  MGauge(Gauge)
}

pub struct Registry {
  metrics: Array[Metric]
}

pub fn Registry::new() -> Registry {
  { metrics: [] }
}

pub fn register_counter(self: Registry, c: Counter) -> Unit {
  self.metrics.push(MCounter(c))
}

pub fn register_gauge(self: Registry, g: Gauge) -> Unit {
  self.metrics.push(MGauge(g))
}
