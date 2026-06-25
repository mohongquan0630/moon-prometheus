
pub struct Label {
  name: String
  value: String
} derive(Show, Eq)

pub type LabelSet Array[Label] derive(Show, Eq)

pub fn LabelSet::new() -> LabelSet {
  []
}
