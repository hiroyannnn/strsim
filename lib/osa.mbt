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
  for j in 0..<=b_len {
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
