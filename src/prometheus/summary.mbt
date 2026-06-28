
pub struct Summary {
  name: String
  help: String
  labels: LabelSet
  mut sum: Double
  mut count: Double
} derive(Show)

pub fn Summary::new(name: String, help: String, ~labels: LabelSet = LabelSet::new([])) -> Summary {
  { name, help, labels, sum: 0.0, count: 0.0 }
}

pub fn observe(self: Summary, v: Double) -> Unit {
  self.sum = self.sum + v
  self.count = self.count + 1.0
}
