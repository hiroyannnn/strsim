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

///|
pub fn jaro(a : String, b : String) -> Double {
  let a_chars = a.to_array()
  let b_chars = b.to_array()
  let a_len = a_chars.length()
  let b_len = b_chars.length()
  if a_len == 0 && b_len == 0 {
    return 1.0
  }
  if a_len == 0 || b_len == 0 {
    return 0.0
  }
  let max_len = if a_len > b_len { a_len } else { b_len }
  let search_range = max_len / 2 - 1
  let a_matched = Array::make(a_len, false)
  let b_matched = Array::make(b_len, false)
  let mut matches = 0.0
  for i in 0..<a_len {
    let lo = if i > search_range { i - search_range } else { 0 }
    let hi = @cmp.minimum(i + search_range + 1, b_len)
    for j = lo; j < hi; j = j + 1 {
      if not(b_matched[j]) && a_chars[i] == b_chars[j] {
        a_matched[i] = true
        b_matched[j] = true
        matches += 1.0
        break
      }
    }
  }
  if matches == 0.0 {
    return 0.0
  }
  let mut transpositions = 0.0
  let mut k = 0
  for i in 0..<a_len {
    if a_matched[i] {
      while not(b_matched[k]) {
        k += 1
      }
      if a_chars[i] != b_chars[k] {
        transpositions += 1.0
      }
      k += 1
    }
  }
  let t = transpositions / 2.0
  (
    matches / a_len.to_double() +
    matches / b_len.to_double() +
    (matches - t) / matches
  ) /
  3.0
}

///|
pub fn jaro_winkler(
  a : String,
  b : String,
  prefix_weight? : Double = 0.1,
) -> Double {
  let jaro_score = jaro(a, b)
  if jaro_score <= 0.7 {
    return jaro_score
  }
  let a_chars = a.to_array()
  let b_chars = b.to_array()
  let prefix_len = @cmp.minimum(
    4,
    @cmp.minimum(a_chars.length(), b_chars.length()),
  )
  let mut common_prefix = 0.0
  for i in 0..<prefix_len {
    if a_chars[i] == b_chars[i] {
      common_prefix += 1.0
    } else {
      break
    }
  }
  jaro_score + prefix_weight * common_prefix * (1.0 - jaro_score)
}
