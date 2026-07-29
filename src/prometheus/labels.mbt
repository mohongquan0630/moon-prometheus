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
  { labels, }
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
    s.write_string(label.value)
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
    s.write_string(label.value)
    s.write_string("\"")
  }
  if self.labels.length() > 0 {
    s.write_string(",")
  }
  s.write_string("le=\"")
  s.write_string(le)
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
pub impl Show for LabelSet with fn output(self, logger) {
  logger.write_string(self.to_string())
}
