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
  let search_range = if max_len / 2 > 0 { max_len / 2 - 1 } else { 0 }
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
  let weight = @cmp.maximum(0.0, @cmp.minimum(prefix_weight, 0.25))
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
  jaro_score + weight * common_prefix * (1.0 - jaro_score)
}
