
pub struct Label {
  name: String
  value: String
} derive(Show, Eq)

pub type LabelSet Array[Label] derive(Show, Eq)

pub fn LabelSet::new(labels: Array[Label]) -> LabelSet {
  labels
}

pub fn LabelSet::to_string(self : LabelSet) -> String {
  if self._.length() == 0 {
    return ""
  }
  let mut s = "{"
  for i = 0; i < self._.length(); i = i + 1 {
    if i > 0 {
      s = s + ","
    }
    s = s + self._[i].name + "=\"" + self._[i].value + "\""
  }
  s + "}"
}
