///|
pub struct Counter {
  name : String
  help : String
  labels : LabelSet
  mut value : Double
} derive(Debug)

///|
pub fn Counter::new(
  name : String,
  help : String,
  labels? : LabelSet = LabelSet::new([]),
) -> Counter {
  { name, help, labels, value: 0.0 }
}

///|
pub fn Counter::inc(self : Counter) -> Unit {
  self.value = self.value + 1.0
}

///|
pub fn Counter::add(self : Counter, v : Double) -> Unit {
  if v >= 0.0 {
    self.value = self.value + v
  }
}

///|
pub fn Counter::value(self : Counter) -> Double {
  self.value
}

///|
pub fn Counter::name(self : Counter) -> String {
  self.name
}

///|
pub fn Counter::help(self : Counter) -> String {
  self.help
}
