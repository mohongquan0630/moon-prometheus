///|
pub(all) struct Label {
  name : String
  value : String
} derive(Debug, Eq)

///|
pub(all) struct LabelSet {
  labels : Array[Label]
} derive(Debug, Eq)

///|
pub fn LabelSet::new(labels : Array[Label]) -> LabelSet {
  { labels: normalize_labels(labels) }
}

///|
pub fn LabelSet::from_pairs(pairs : Array[(String, String)]) -> LabelSet {
  let labels = pairs.map(fn(pair) {
    let (name, value) = pair
    { name, value }
  })
  LabelSet::new(labels)
}

///|
fn normalize_labels(labels : Array[Label]) -> Array[Label] {
  let sorted : Array[Label] = []
  for label in labels {
    sorted.push(label)
  }
  sorted.sort_by(fn(a, b) { lexical_compare(a.name, b.name) })
  let result : Array[Label] = []
  for label in sorted {
    if result.length() == 0 || result[result.length() - 1].name != label.name {
      result.push(label)
    } else {
      result[result.length() - 1] = label
    }
  }
  result
}

///|
pub fn LabelSet::get(self : LabelSet, name : String) -> String? {
  for label in self.labels {
    if label.name == name {
      return Some(label.value)
    }
  }
  None
}

///|
pub fn LabelSet::contains(self : LabelSet, name : String) -> Bool {
  self.get(name) is Some(_)
}

///|
pub fn LabelSet::with_label(
  self : LabelSet,
  name : String,
  value : String,
) -> LabelSet {
  let labels : Array[Label] = []
  for label in self.labels {
    labels.push(label)
  }
  labels.push({ name, value })
  LabelSet::new(labels)
}

///|
pub fn LabelSet::merge(self : LabelSet, other : LabelSet) -> LabelSet {
  let labels : Array[Label] = []
  for label in self.labels {
    labels.push(label)
  }
  for label in other.labels {
    labels.push(label)
  }
  LabelSet::new(labels)
}

///|
pub fn LabelSet::to_string(self : LabelSet) -> String {
  if self.labels.length() == 0 {
    return ""
  }
  let s = StringBuilder::new()
  s.write_string("{")
  for i = 0; i < self.labels.length(); i = i + 1 {
    if i > 0 {
      s.write_string(",")
    }
    let label = self.labels[i]
    s.write_string(label.name)
    s.write_string("=\"")
    s.write_string(escape_label_value(label.value))
    s.write_string("\"")
  }
  s.write_string("}")
  s.to_string()
}

///|
pub fn LabelSet::to_bucket_string(self : LabelSet, le : String) -> String {
  let s = StringBuilder::new()
  s.write_string("{")
  for i = 0; i < self.labels.length(); i = i + 1 {
    if i > 0 {
      s.write_string(",")
    }
    let label = self.labels[i]
    s.write_string(label.name)
    s.write_string("=\"")
    s.write_string(escape_label_value(label.value))
    s.write_string("\"")
  }
  if self.labels.length() > 0 {
    s.write_string(",")
  }
  s.write_string("le=\"")
  s.write_string(escape_label_value(le))
  s.write_string("\"}")
  s.to_string()
}

///|
pub fn LabelSet::length(self : LabelSet) -> Int {
  self.labels.length()
}

///|
pub fn LabelSet::is_empty(self : LabelSet) -> Bool {
  self.labels.length() == 0
}

///|
pub fn LabelSet::is_valid(self : LabelSet) -> Bool {
  let names : Array[String] = []
  for label in self.labels {
    if !validate_label_name(label.name) || names.contains(label.name) {
      return false
    }
    names.push(label.name)
  }
  true
}

///|
pub fn LabelSet::names(self : LabelSet) -> Array[String] {
  let names : Array[String] = []
  for label in self.labels {
    names.push(label.name)
  }
  names
}

///|
pub impl Show for LabelSet with fn output(self, logger) {
  logger.write_string(self.to_string())
}
