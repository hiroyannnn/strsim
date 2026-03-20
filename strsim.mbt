///|
pub(all) suberror StrsimError {
  UnequalLength
}

///|
pub impl Show for StrsimError with output(self, logger) {
  match self {
    UnequalLength => logger.write_string("UnequalLength")
  }
}

///|
pub fn hamming(a : String, b : String) -> Int raise StrsimError {
  let a_chars = a.to_array()
  let b_chars = b.to_array()
  if a_chars.length() != b_chars.length() {
    raise UnequalLength
  }
  let mut count = 0
  for i in 0..<a_chars.length() {
    if a_chars[i] != b_chars[i] {
      count += 1
    }
  }
  count
}

///|
pub fn levenshtein(a : String, b : String) -> Int {
  let a_chars = a.to_array()
  let b_chars = b.to_array()
  let a_len = a_chars.length()
  let b_len = b_chars.length()
  if a_len == 0 {
    return b_len
  }
  if b_len == 0 {
    return a_len
  }
  let cache = Array::make(b_len, 0)
  for j in 0..<b_len {
    cache[j] = j + 1
  }
  let mut result = 0
  for i in 0..<a_len {
    result = i + 1
    let mut distance_b = i
    for j in 0..<b_len {
      let cost = if a_chars[i] == b_chars[j] { 0 } else { 1 }
      let distance_a = cache[j]
      let ins = result + 1
      let del = distance_a + 1
      let sub = distance_b + cost
      result = @cmp.minimum(ins, @cmp.minimum(del, sub))
      cache[j] = result
      distance_b = distance_a
    }
  }
  result
}

///|
pub fn normalized_levenshtein(a : String, b : String) -> Double {
  let a_len = a.to_array().length()
  let b_len = b.to_array().length()
  if a_len == 0 && b_len == 0 {
    return 1.0
  }
  let max_len = if a_len > b_len { a_len } else { b_len }
  1.0 - levenshtein(a, b).to_double() / max_len.to_double()
}
