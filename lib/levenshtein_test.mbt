///|
test "levenshtein/kitten-sitting" {
  inspect(@lib.levenshtein("kitten", "sitting"), content="3")
}

///|
test "levenshtein/empty strings" {
  inspect(@lib.levenshtein("", ""), content="0")
}

///|
test "levenshtein/one empty" {
  inspect(@lib.levenshtein("", "abc"), content="3")
  inspect(@lib.levenshtein("abc", ""), content="3")
}

///|
test "levenshtein/equal strings" {
  inspect(@lib.levenshtein("abc", "abc"), content="0")
}

///|
test "levenshtein/single char" {
  inspect(@lib.levenshtein("a", "b"), content="1")
  inspect(@lib.levenshtein("a", "a"), content="0")
}

///|
test "normalized_levenshtein/kitten-sitting" {
  let result = @lib.normalized_levenshtein("kitten", "sitting")
  assert_true(result > 0.571 && result < 0.572)
}

///|
test "normalized_levenshtein/empty strings" {
  inspect(@lib.normalized_levenshtein("", ""), content="1")
}

///|
test "normalized_levenshtein/equal strings" {
  inspect(@lib.normalized_levenshtein("abc", "abc"), content="1")
}

///|
test "normalized_levenshtein/completely different" {
  inspect(@lib.normalized_levenshtein("abc", "xyz"), content="0")
}

///|
test "unicode/levenshtein" {
  inspect(@lib.levenshtein("日本語", "日本人"), content="1")
}
