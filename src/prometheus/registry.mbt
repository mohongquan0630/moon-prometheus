///|
enum Metric {
  MCounter(Counter)
  MGauge(Gauge)
  MHistogram(Histogram)
  MSummary(Summary)
}

///|
pub struct Registry {
  metrics : Map[String, Metric]
}

///|
pub fn Registry::new() -> Registry {
  { metrics: Map([]) }
}

///|
pub fn Registry::register_counter(self : Registry, c : Counter) -> Unit {
  self.metrics.set(c.name, MCounter(c))
}

///|
pub fn Registry::register_gauge(self : Registry, g : Gauge) -> Unit {
  self.metrics.set(g.name, MGauge(g))
}

///|
pub fn Registry::register_histogram(self : Registry, h : Histogram) -> Unit {
  self.metrics.set(h.name, MHistogram(h))
}

///|
fn Registry::get_metrics(self : Registry) -> Array[Metric] {
  let arr = []
  for _, v in self.metrics {
    arr.push(v)
  }
  arr
}

///|
pub fn Registry::register_summary(self : Registry, s : Summary) -> Unit {
  self.metrics.set(s.name, MSummary(s))
}

///|
pub fn Registry::len(self : Registry) -> Int {
  let mut count = 0
  for _, _ in self.metrics {
    count = count + 1
  }
  count
}

///|
pub fn Registry::is_empty(self : Registry) -> Bool {
  self.len() == 0
}

///|
pub fn Registry::contains(self : Registry, name : String) -> Bool {
  for key, _ in self.metrics {
    if key == name {
      return true
    }
  }
  false
}
