///|
pub fn lcs_length(a : String, b : String) -> Int {
  let a_chars = a.to_array()
  let b_chars = b.to_array()
  let a_len = a_chars.length()
  let b_len = b_chars.length()
  if a_len == 0 || b_len == 0 {
    return 0
  }
  let prev = Array::make(b_len + 1, 0)
  let curr = Array::make(b_len + 1, 0)
  for i in 1..<=a_len {
    for j in 1..<=b_len {
      if a_chars[i - 1] == b_chars[j - 1] {
        curr[j] = prev[j - 1] + 1
      } else {
        curr[j] = @cmp.maximum(prev[j], curr[j - 1])
      }
    }
    for j in 0..<=b_len {
      prev[j] = curr[j]
      curr[j] = 0
    }
  }
  prev[b_len]
}
