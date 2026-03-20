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

///|
pub fn osa_distance(a : String, b : String) -> Int {
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
  let mut prev_two : Array[Int] = Array::new(capacity=b_len + 1)
  let mut prev : Array[Int] = Array::new(capacity=b_len + 1)
  let mut curr : Array[Int] = Array::make(b_len + 1, 0)
  for j in 0..=b_len {
    prev_two.push(j)
    prev.push(j)
  }
  let mut prev_a_char = '\u0000'
  for i in 0..<a_len {
    curr[0] = i + 1
    let mut prev_b_char = '\u0000'
    for j in 0..<b_len {
      let cost = if a_chars[i] == b_chars[j] { 0 } else { 1 }
      curr[j + 1] = @cmp.minimum(
        curr[j] + 1,
        @cmp.minimum(prev[j + 1] + 1, prev[j] + cost),
      )
      if i > 0 &&
        j > 0 &&
        a_chars[i] != b_chars[j] &&
        a_chars[i] == prev_b_char &&
        b_chars[j] == prev_a_char {
        curr[j + 1] = @cmp.minimum(curr[j + 1], prev_two[j - 1] + 1)
      }
      prev_b_char = b_chars[j]
    }
    let tmp = prev_two
    prev_two = prev
    prev = curr
    curr = tmp
    prev_a_char = a_chars[i]
  }
  prev[b_len]
}

///|
pub fn damerau_levenshtein(a : String, b : String) -> Int {
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
  let width = a_len + 2
  let height = b_len + 2
  let d = Array::make(width * height, 0)
  let max_dist = a_len + b_len
  d[0] = max_dist
  for i in 0..=a_len {
    d[i + 1 + 0 * width] = max_dist
    d[i + 1 + 1 * width] = i
  }
  for j in 0..=b_len {
    d[0 + (j + 1) * width] = max_dist
    d[1 + (j + 1) * width] = j
  }
  let last_row : Map[Char, Int] = {}
  for i in 1..=a_len {
    let mut db = 0
    for j in 1..=b_len {
      let k = last_row.get(b_chars[j - 1]).unwrap_or(0)
      let ins = d[i + (j + 1) * width] + 1
      let del = d[i + 1 + j * width] + 1
      let trans = d[k + db * width] + (i - k - 1) + 1 + (j - db - 1)
      let mut sub = d[i + j * width] + 1
      if a_chars[i - 1] == b_chars[j - 1] {
        db = j
        sub -= 1
      }
      d[i + 1 + (j + 1) * width] = @cmp.minimum(
        sub,
        @cmp.minimum(ins, @cmp.minimum(del, trans)),
      )
    }
    last_row[a_chars[i - 1]] = i
  }
  d[a_len + 1 + (b_len + 1) * width]
}
