
enum Metric {
  MCounter(Counter)
  MGauge(Gauge)
}

pub struct Registry {
  metrics: Map[String, Metric]
}

pub fn Registry::new() -> Registry {
  { metrics: Map::new() }
}

pub fn register_counter(self: Registry, c: Counter) -> Unit {
  self.metrics.set(c.name, MCounter(c))
}

pub fn register_gauge(self: Registry, g: Gauge) -> Unit {
  self.metrics.set(g.name, MGauge(g))
}

pub fn get_metrics(self: Registry) -> Array[Metric] {
  let arr = []
  for _, v in self.metrics {
    arr.push(v)
  }
  arr
}
