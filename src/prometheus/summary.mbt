///|
pub struct Summary {
  name : String
  help : String
  labels : LabelSet
  quantiles : Array[Double]
  observations : Array[Double]
  mut sum : Double
  mut count : Double
} derive(Debug)

///|
pub fn Summary::new(
  name : String,
  help : String,
  labels? : LabelSet = LabelSet::new([]),
  quantiles? : Array[Double] = [0.5, 0.9, 0.99],
) -> Summary {
  let normalized = quantiles.filter(fn(q) { q >= 0.0 && q <= 1.0 })
  normalized.sort()
  {
    name,
    help,
    labels,
    quantiles: normalized,
    observations: [],
    sum: 0.0,
    count: 0.0,
  }
}

///|
pub fn Summary::observe(self : Summary, v : Double) -> Unit {
  self.sum = self.sum + v
  self.count = self.count + 1.0
  self.observations.push(v)
}

///|
pub fn Summary::sum(self : Summary) -> Double {
  self.sum
}

///|
pub fn Summary::count(self : Summary) -> Double {
  self.count
}

///|
pub fn Summary::mean(self : Summary) -> Double {
  if self.count == 0.0 {
    0.0
  } else {
    self.sum / self.count
  }
}

///|
pub fn Summary::quantile(self : Summary, q : Double) -> Double? {
  if self.observations.length() == 0 || q < 0.0 || q > 1.0 {
    None
  } else {
    let values : Array[Double] = []
    for value in self.observations {
      values.push(value)
    }
    values.sort()
    let raw = @math.ceil((values.length() - 1).to_double() * q).to_int()
    Some(values[raw])
  }
}

///|
pub fn Summary::quantile_values(self : Summary) -> Array[(Double, Double)] {
  self.quantiles.filter_map(fn(q) {
    match self.quantile(q) {
      Some(value) => Some((q, value))
      None => None
    }
  })
}
