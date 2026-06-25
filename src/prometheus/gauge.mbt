
pub struct Gauge {
  name: String
  help: String
  labels: LabelSet
  mut value: Double
} derive(Show)

pub fn Gauge::new(name: String, help: String, ~labels: LabelSet = LabelSet::new([])) -> Gauge {
  { name, help, labels, value: 0.0 }
}

pub fn inc(self: Gauge) -> Unit {
  self.value = self.value + 1.0
}

pub fn dec(self: Gauge) -> Unit {
  self.value = self.value - 1.0
}

pub fn set(self: Gauge, v: Double) -> Unit {
  self.value = v
}
