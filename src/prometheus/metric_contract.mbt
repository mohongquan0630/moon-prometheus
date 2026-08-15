///|
pub(all) enum MetricType {
  CounterType
  GaugeType
  HistogramType
  SummaryType
} derive(Debug, Eq)

///|
pub(all) struct MetricDescriptor {
  name : String
  help : String
  metric_type : MetricType
  label_names : Array[String]
} derive(Debug)

///|
pub fn MetricDescriptor::new(
  name : String,
  help : String,
  metric_type : MetricType,
  label_names : Array[String],
) -> MetricDescriptor {
  let normalized : Array[String] = []
  for label_name in label_names {
    if !normalized.contains(label_name) {
      normalized.push(label_name)
    }
  }
  normalized.sort_by(fn(left, right) { lexical_compare(left, right) })
  { name, help, metric_type, label_names: normalized }
}

///|
pub fn MetricDescriptor::is_valid(self : MetricDescriptor) -> Bool {
  if !validate_metric_name(self.name) || self.help.length() == 0 {
    false
  } else {
    let seen : Array[String] = []
    for label_name in self.label_names {
      if !validate_label_name(label_name) || seen.contains(label_name) {
        return false
      }
      seen.push(label_name)
    }
    true
  }
}

///|
pub fn MetricDescriptor::label_names(self : MetricDescriptor) -> Array[String] {
  let result : Array[String] = []
  for label_name in self.label_names {
    result.push(label_name)
  }
  result
}

///|
pub fn MetricDescriptor::accepts_labels(
  self : MetricDescriptor,
  labels : LabelSet,
) -> Bool {
  if labels.length() != self.label_names.length() {
    false
  } else {
    for label_name in self.label_names {
      if !labels.contains(label_name) {
        return false
      }
    }
    true
  }
}

///|
fn metric_type_name(metric_type : MetricType) -> String {
  match metric_type {
    CounterType => "counter"
    GaugeType => "gauge"
    HistogramType => "histogram"
    SummaryType => "summary"
  }
}

///|
pub fn MetricDescriptor::summary(self : MetricDescriptor) -> String {
  let labels = if self.label_names.length() == 0 {
    ""
  } else {
    "{\{self.label_names.join(",")}}"
  }
  metric_type_name(self.metric_type) +
  " " +
  self.name +
  " " +
  labels +
  ": " +
  self.help
}
