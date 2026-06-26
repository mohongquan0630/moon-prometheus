
pub fn Registry::to_text_format(self: Registry) -> String {
  let mut s = ""
  for m in self.get_metrics() {
    match m {
      MCounter(c) => {
        s = s + "# HELP " + c.name + " " + c.help + "\n"
        s = s + "# TYPE " + c.name + " counter\n"
        s = s + c.name + c.labels.to_string() + " " + c.value.to_string() + "\n"
      }
      MGauge(g) => {
        s = s + "# HELP " + g.name + " " + g.help + "\n"
        s = s + "# TYPE " + g.name + " gauge\n"
        s = s + g.name + g.labels.to_string() + " " + g.value.to_string() + "\n"
      }
    }
  }
  s
}
