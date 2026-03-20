///|
test "jaro/nietzsche-sartre" {
  let result = jaro("Friedrich Nietzsche", "Jean-Paul Sartre")
  assert_true(result > 0.391 && result < 0.393)
}

///|
test "jaro/empty strings" {
  inspect(jaro("", ""), content="1")
}

///|
test "jaro/one empty" {
  inspect(jaro("", "abc"), content="0")
  inspect(jaro("abc", ""), content="0")
}

///|
test "jaro/identical" {
  inspect(jaro("abc", "abc"), content="1")
}

///|
test "jaro/single char identical" {
  inspect(jaro("a", "a"), content="1")
}

///|
test "jaro/single char different" {
  inspect(jaro("a", "b"), content="0")
}

///|
test "unicode/jaro" {
  inspect(jaro("日本語", "日本語"), content="1")
}

///|
test "jaro_winkler/cheeseburger" {
  let result = jaro_winkler("cheeseburger", "cheese fries")
  assert_true(result > 0.865 && result < 0.867)
}

///|
test "jaro_winkler/empty strings" {
  inspect(jaro_winkler("", ""), content="1")
}

///|
test "jaro_winkler/one empty" {
  inspect(jaro_winkler("", "abc"), content="0")
  inspect(jaro_winkler("abc", ""), content="0")
}

///|
test "jaro_winkler/identical" {
  inspect(jaro_winkler("abc", "abc"), content="1")
}

///|
test "jaro_winkler/single char identical" {
  inspect(jaro_winkler("a", "a"), content="1")
}

///|
test "jaro_winkler/prefix_weight_clamped" {
  let result_high = jaro_winkler("abc", "abd", prefix_weight=0.5)
  assert_true(result_high <= 1.0)
  let result_neg = jaro_winkler("abc", "abd", prefix_weight=-0.5)
  assert_true(result_neg >= 0.0)
  let result_default = jaro_winkler("abc", "abd")
  assert_true(result_neg <= result_default)
}
