
enum Metric {
  MCounter(Counter)
  MGauge(Gauge)
  MHistogram(Histogram)
  MSummary(Summary)
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

pub fn register_histogram(self: Registry, h: Histogram) -> Unit {
  self.metrics.set(h.name, MHistogram(h))
}

pub fn get_metrics(self: Registry) -> Array[Metric] {
  let arr = []
  for _, v in self.metrics {
    arr.push(v)
  }
  arr
}

pub fn register_summary(self: Registry, s: Summary) -> Unit {
  self.metrics.set(s.name, MSummary(s))
}
