///|
pub fn sorensen_dice(a : String, b : String) -> Double {
  let a_chars = a.iter().filter(fn(c) { not(c.is_whitespace()) }).collect()
  let b_chars = b.iter().filter(fn(c) { not(c.is_whitespace()) }).collect()
  let a_len : Int = a_chars.length()
  let b_len : Int = b_chars.length()
  if a_chars == b_chars {
    return 1.0
  }
  if a_len < 2 || b_len < 2 {
    return 0.0
  }
  let a_bigrams : Map[String, Int] = {}
  for i in 0..<(a_len - 1) {
    let key = Char::to_string(a_chars[i]) + Char::to_string(a_chars[i + 1])
    a_bigrams[key] = a_bigrams.get(key).unwrap_or(0) + 1
  }
  let mut intersection = 0
  for i in 0..<(b_len - 1) {
    let key = Char::to_string(b_chars[i]) + Char::to_string(b_chars[i + 1])
    let count = a_bigrams.get(key).unwrap_or(0)
    if count > 0 {
      a_bigrams[key] = count - 1
      intersection += 1
    }
  }
  (2 * intersection).to_double() / (a_len + b_len - 2).to_double()
}
