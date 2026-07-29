///|
pub struct Histogram {
  name : String
  help : String
  labels : LabelSet
  buckets : Array[Double]
  counts : Array[Double]
  mut sum : Double
} derive(Debug)

///|
pub fn Histogram::new(
  name : String,
  help : String,
  buckets? : Array[Double] = [0.1, 0.5, 1.0, 5.0, 10.0],
  labels? : LabelSet = LabelSet::new([]),
) -> Histogram {
  let counts = Array::make(buckets.length() + 1, 0.0)
  { name, help, labels, buckets, counts, sum: 0.0 }
}

///|
pub fn Histogram::observe(self : Histogram, v : Double) -> Unit {
  self.sum = self.sum + v
  let mut found = false
  for i = 0; i < self.buckets.length(); i = i + 1 {
    if v <= self.buckets[i] {
      self.counts[i] = self.counts[i] + 1.0
      found = true
      break
    }
  }
  if !found {
    self.counts[self.buckets.length()] = self.counts[self.buckets.length()] +
      1.0
  }
}

///|
pub fn Histogram::sum(self : Histogram) -> Double {
  self.sum
}

///|
pub fn Histogram::count(self : Histogram) -> Double {
  self.counts.fold(init=0.0, fn(acc, v) { acc + v })
}

///|
pub fn Histogram::bucket_count(self : Histogram, index : Int) -> Double {
  if index < 0 || index >= self.counts.length() {
    0.0
  } else {
    self.counts[index]
  }
}
