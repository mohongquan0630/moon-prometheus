///|
pub struct PushGateway {
  url : String
  job : String
}

///|
pub fn PushGateway::new(url : String, job : String) -> PushGateway {
  { url, job }
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
  self.url + "/metrics/job/" + self.job
}
