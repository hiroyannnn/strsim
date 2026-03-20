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
