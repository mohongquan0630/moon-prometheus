///|
pub fn Registry::to_text_format(self : Registry) -> String {
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
      MHistogram(h) => {
        s = s + "# HELP " + h.name + " " + h.help + "\n"
        s = s + "# TYPE " + h.name + " histogram\n"
        let mut total_count = 0.0
        for i = 0; i < h.buckets.length(); i = i + 1 {
          total_count = total_count + h.counts[i]
          s = s +
            h.name +
            "_bucket" +
            h.labels.to_bucket_string(h.buckets[i].to_string()) +
            " " +
            total_count.to_string() +
            "\n"
        }
        total_count = total_count + h.counts[h.buckets.length()]
        s = s +
          h.name +
          "_bucket" +
          h.labels.to_bucket_string("+Inf") +
          " " +
          total_count.to_string() +
          "\n"
        s = s +
          h.name +
          "_sum" +
          h.labels.to_string() +
          " " +
          h.sum.to_string() +
          "\n"
        s = s +
          h.name +
          "_count" +
          h.labels.to_string() +
          " " +
          total_count.to_string() +
          "\n"
      }
      MSummary(su) => {
        s = s + "# HELP " + su.name + " " + su.help + "\n"
        s = s + "# TYPE " + su.name + " summary\n"
        s = s +
          su.name +
          "_sum" +
          su.labels.to_string() +
          " " +
          su.sum.to_string() +
          "\n"
        s = s +
          su.name +
          "_count" +
          su.labels.to_string() +
          " " +
          su.count.to_string() +
          "\n"
      }
    }
  }
  s
}
