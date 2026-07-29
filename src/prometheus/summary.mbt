///|
pub struct Summary {
  name : String
  help : String
  labels : LabelSet
  mut sum : Double
  mut count : Double
} derive(Debug)

///|
pub fn Summary::new(
  name : String,
  help : String,
  labels? : LabelSet = LabelSet::new([]),
) -> Summary {
  { name, help, labels, sum: 0.0, count: 0.0 }
}

///|
pub fn Summary::observe(self : Summary, v : Double) -> Unit {
  self.sum = self.sum + v
  self.count = self.count + 1.0
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
