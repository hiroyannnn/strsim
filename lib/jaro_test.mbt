///|
test "jaro/nietzsche-sartre" {
  let result = @lib.jaro("Friedrich Nietzsche", "Jean-Paul Sartre")
  assert_true(result > 0.391 && result < 0.393)
}

///|
test "jaro/empty strings" {
  inspect(@lib.jaro("", ""), content="1")
}

///|
test "jaro/one empty" {
  inspect(@lib.jaro("", "abc"), content="0")
  inspect(@lib.jaro("abc", ""), content="0")
}

///|
test "jaro/identical" {
  inspect(@lib.jaro("abc", "abc"), content="1")
}

///|
test "jaro/single char identical" {
  inspect(@lib.jaro("a", "a"), content="1")
}

///|
test "jaro/single char different" {
  inspect(@lib.jaro("a", "b"), content="0")
}

///|
test "unicode/jaro" {
  inspect(@lib.jaro("日本語", "日本語"), content="1")
}

///|
test "jaro_winkler/cheeseburger" {
  let result = @lib.jaro_winkler("cheeseburger", "cheese fries")
  assert_true(result > 0.865 && result < 0.867)
}

///|
test "jaro_winkler/empty strings" {
  inspect(@lib.jaro_winkler("", ""), content="1")
}

///|
test "jaro_winkler/one empty" {
  inspect(@lib.jaro_winkler("", "abc"), content="0")
  inspect(@lib.jaro_winkler("abc", ""), content="0")
}

///|
test "jaro_winkler/identical" {
  inspect(@lib.jaro_winkler("abc", "abc"), content="1")
}

///|
test "jaro_winkler/single char identical" {
  inspect(@lib.jaro_winkler("a", "a"), content="1")
}

///|
test "jaro_winkler/prefix_weight_clamped" {
  let result_high = @lib.jaro_winkler("abc", "abd", prefix_weight=0.5)
  assert_true(result_high <= 1.0)
  let result_neg = @lib.jaro_winkler("abc", "abd", prefix_weight=-0.5)
  assert_true(result_neg >= 0.0)
  let result_default = @lib.jaro_winkler("abc", "abd")
  assert_true(result_neg <= result_default)
}
