///|
pub struct Gauge {
  name : String
  help : String
  labels : LabelSet
  mut value : Double
} derive(Debug)

///|
pub fn Gauge::new(
  name : String,
  help : String,
  labels? : LabelSet = LabelSet::new([]),
) -> Gauge {
  { name, help, labels, value: 0.0 }
}

///|
pub fn Gauge::inc(self : Gauge) -> Unit {
  self.value = self.value + 1.0
}

///|
pub fn Gauge::dec(self : Gauge) -> Unit {
  self.value = self.value - 1.0
}

///|
pub fn Gauge::set(self : Gauge, v : Double) -> Unit {
  self.value = v
}

///|
pub fn Gauge::add(self : Gauge, v : Double) -> Unit {
  self.value = self.value + v
}

///|
pub fn Gauge::sub(self : Gauge, v : Double) -> Unit {
  self.value = self.value - v
}

///|
pub fn Gauge::value(self : Gauge) -> Double {
  self.value
}

///|
pub fn Gauge::name(self : Gauge) -> String {
  self.name
}
