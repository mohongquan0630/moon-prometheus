///|
pub struct PushGateway {
  url : String
  job : String
  grouping : LabelSet
}

///|
pub fn PushGateway::new(url : String, job : String) -> PushGateway {
  let normalized_url = if url.has_suffix("/") {
    url[:url.length() - 1].to_owned()
  } else {
    url
  }
  { url: normalized_url, job, grouping: LabelSet::new([]) }
}

///|
pub fn PushGateway::with_grouping_labels(
  self : PushGateway,
  grouping : LabelSet,
) -> PushGateway {
  { ..self, grouping, }
}

///|
pub fn PushGateway::format_push_payload(
  _self : PushGateway,
  registry : Registry,
) -> String {
  registry.to_text_format()
}

///|
pub fn PushGateway::push_url(self : PushGateway) -> String {
  let base = self.url + "/metrics/job/" + percent_encode_path_segment(self.job)
  let mut out = base
  for label in self.grouping.labels {
    out = out + "/" + percent_encode_path_segment(label.name)
    out = out + "/" + percent_encode_path_segment(label.value)
  }
  out
}

///|
fn percent_encode_path_segment(value : String) -> String {
  let hex = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F",
  ]
  let out = StringBuilder::new()
  for c in value {
    let allowed = (c >= 'a' && c <= 'z') ||
      (c >= 'A' && c <= 'Z') ||
      (c >= '0' && c <= '9') ||
      c == '-' ||
      c == '_' ||
      c == '.' ||
      c == '~'
    if allowed {
      out.write_char(c)
    } else {
      let code = c.to_int()
      out.write_string("%")
      out.write_string(hex[code / 16])
      out.write_string(hex[code % 16])
    }
  }
  out.to_string()
}
