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
  let d = Array::make(width * (b_len + 2), 0)
  let max_dist = a_len + b_len
  d[0] = max_dist
  for i in 0..<=a_len {
    d[i + 1 + 0 * width] = max_dist
    d[i + 1 + 1 * width] = i
  }
  for j in 0..<=b_len {
    d[0 + (j + 1) * width] = max_dist
    d[1 + (j + 1) * width] = j
  }
  let last_row : Map[Char, Int] = {}
  for i in 1..<=a_len {
    let mut db = 0
    for j in 1..<=b_len {
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
