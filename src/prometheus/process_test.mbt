
test "ProcessCollector registration" {
  let reg = Registry::new()
  let _ = ProcessCollector::new(reg)
  let out = reg.to_text_format()
  assert_true(out.contains("process_cpu_seconds_total"))
  assert_true(out.contains("process_virtual_memory_bytes"))
}
