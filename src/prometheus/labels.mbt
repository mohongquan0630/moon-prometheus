
pub(all) struct Label {
  name: String
  value: String
} derive(Debug, Eq)

pub(all) struct LabelSet {
  labels: Array[Label]
} derive(Debug, Eq)

pub fn LabelSet::new(labels: Array[Label]) -> LabelSet {
  { labels: labels }
}

pub fn LabelSet::to_string(self : LabelSet) -> String {
  if self.labels.length() == 0 {
    return ""
  }
  let mut s = "{"
  for i = 0; i < self.labels.length(); i = i + 1 {
    if i > 0 {
      s = s + ","
    }
    let label = self.labels[i]
    let name = label.name
    let value = label.value
    s = s + "\{name}=\"\{value}\""
  }
  s + "}"
}

pub impl Show for LabelSet with output(self, logger) {
  logger.write_string(self.to_string())
}
