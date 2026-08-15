///|
pub struct ProcessCollector {
  registry : Registry
  cpu_seconds : Gauge
  virtual_memory_bytes : Gauge
  open_file_descriptors : Gauge
}

///|
pub fn ProcessCollector::new(registry : Registry) -> ProcessCollector {
  let cpu_gauge = Gauge::new(
    "process_cpu_seconds_total", "Total user and system CPU time spent in seconds",
  )
  let mem_gauge = Gauge::new(
    "process_virtual_memory_bytes", "Virtual memory size in bytes",
  )
  let fds_gauge = Gauge::new(
    "process_open_fds", "Number of open file descriptors",
  )

  registry.register_gauge(cpu_gauge)
  registry.register_gauge(mem_gauge)
  registry.register_gauge(fds_gauge)
  {
    registry,
    cpu_seconds: cpu_gauge,
    virtual_memory_bytes: mem_gauge,
    open_file_descriptors: fds_gauge,
  }
}

///|
pub fn ProcessCollector::set_cpu_seconds(
  self : ProcessCollector,
  value : Double,
) -> Unit {
  self.cpu_seconds.set(value)
}

///|
pub fn ProcessCollector::set_virtual_memory_bytes(
  self : ProcessCollector,
  value : Double,
) -> Unit {
  self.virtual_memory_bytes.set(value)
}

///|
pub fn ProcessCollector::set_open_file_descriptors(
  self : ProcessCollector,
  value : Double,
) -> Unit {
  self.open_file_descriptors.set(value)
}

///|
pub fn ProcessCollector::collect(self : ProcessCollector) -> Unit {
  self.registry.register_gauge(self.cpu_seconds)
  self.registry.register_gauge(self.virtual_memory_bytes)
  self.registry.register_gauge(self.open_file_descriptors)
}
