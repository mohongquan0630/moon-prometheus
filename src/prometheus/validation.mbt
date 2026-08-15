///|
fn is_ascii_letter(c : Char) -> Bool {
  (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}

///|
fn is_name_tail(c : Char) -> Bool {
  is_ascii_letter(c) || (c >= '0' && c <= '9') || c == '_' || c == ':'
}

///|
fn lexical_compare(left : String, right : String) -> Int {
  let left_chars = left.to_array()
  let right_chars = right.to_array()
  let common = if left_chars.length() < right_chars.length() {
    left_chars.length()
  } else {
    right_chars.length()
  }
  for index in 0..<common {
    if left_chars[index] < right_chars[index] {
      return -1
    } else if left_chars[index] > right_chars[index] {
      return 1
    }
  }
  if left_chars.length() < right_chars.length() {
    -1
  } else if left_chars.length() > right_chars.length() {
    1
  } else {
    0
  }
}

///|
pub fn validate_metric_name(name : String) -> Bool {
  if name.length() == 0 {
    false
  } else {
    let first = name.get_char(0)
    match first {
      Some(c) =>
        if !(is_ascii_letter(c) || c == '_' || c == ':') {
          false
        } else {
          for c in name[1:] {
            if !is_name_tail(c) {
              return false
            }
          }
          true
        }
      None => false
    }
  }
}

///|
pub fn validate_label_name(name : String) -> Bool {
  if name.length() == 0 {
    false
  } else {
    let first = name.get_char(0)
    match first {
      Some(c) =>
        if !(is_ascii_letter(c) || c == '_') {
          false
        } else {
          for c in name[1:] {
            if !(is_ascii_letter(c) || (c >= '0' && c <= '9') || c == '_') {
              return false
            }
          }
          true
        }
      None => false
    }
  }
}

///|
pub fn escape_label_value(value : String) -> String {
  let out = StringBuilder::new()
  for c in value {
    match c {
      '\\' => out.write_string("\\\\")
      '"' => out.write_string("\\\"")
      '\n' => out.write_string("\\n")
      _ => out.write_char(c)
    }
  }
  out.to_string()
}
