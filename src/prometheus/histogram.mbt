
pub struct Histogram {
  name: String
  help: String
  labels: LabelSet
  buckets: Array[Double]
  counts: Array[Double]
  mut sum: Double
} derive(Show)

pub fn Histogram::new(name: String, help: String, ~buckets: Array[Double] = [0.1, 0.5, 1.0, 5.0, 10.0], ~labels: LabelSet = LabelSet::new([])) -> Histogram {
  let counts = Array::make(buckets.length() + 1, 0.0)
  { name, help, labels, buckets, counts, sum: 0.0 }
}
