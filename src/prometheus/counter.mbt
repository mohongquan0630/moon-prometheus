
pub struct Counter {
  name: String
  help: String
  labels: LabelSet
  mut value: Double
} derive(Show)

pub fn Counter::new(name: String, help: String, ~labels: LabelSet = LabelSet::new([])) -> Counter {
  { name, help, labels, value: 0.0 }
}

pub fn inc(self: Counter) -> Unit {
  self.value = self.value + 1.0
}

pub fn add(self: Counter, v: Double) -> Unit {
  if v >= 0.0 {
    self.value = self.value + v
  }
}
