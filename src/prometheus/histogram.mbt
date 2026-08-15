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
  let sorted : Array[Double] = []
  for bucket in buckets {
    sorted.push(bucket)
  }
  sorted.sort()
  let normalized : Array[Double] = []
  for bucket in sorted {
    if bucket == bucket &&
      (
        normalized.length() == 0 ||
        normalized[normalized.length() - 1] != bucket
      ) {
      normalized.push(bucket)
    }
  }
  let counts = Array::make(normalized.length() + 1, 0.0)
  { name, help, labels, buckets: normalized, counts, sum: 0.0 }
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

///|
pub fn Histogram::bucket_bounds(self : Histogram) -> Array[Double] {
  let result : Array[Double] = []
  for bucket in self.buckets {
    result.push(bucket)
  }
  result
}

///|
pub fn Histogram::cumulative_bucket_count(
  self : Histogram,
  index : Int,
) -> Double {
  if index < 0 {
    0.0
  } else {
    let last = if index >= self.counts.length() {
      self.counts.length() - 1
    } else {
      index
    }
    let mut total = 0.0
    for i in 0..<=last {
      total = total + self.counts[i]
    }
    total
  }
}
