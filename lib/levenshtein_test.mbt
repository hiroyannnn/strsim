///|
test "levenshtein/kitten-sitting" {
  inspect(levenshtein("kitten", "sitting"), content="3")
}

///|
test "levenshtein/empty strings" {
  inspect(levenshtein("", ""), content="0")
}

///|
test "levenshtein/one empty" {
  inspect(levenshtein("", "abc"), content="3")
  inspect(levenshtein("abc", ""), content="3")
}

///|
test "levenshtein/equal strings" {
  inspect(levenshtein("abc", "abc"), content="0")
}

///|
test "levenshtein/single char" {
  inspect(levenshtein("a", "b"), content="1")
  inspect(levenshtein("a", "a"), content="0")
}

///|
test "normalized_levenshtein/kitten-sitting" {
  let result = normalized_levenshtein("kitten", "sitting")
  assert_true(result > 0.571 && result < 0.572)
}

///|
test "normalized_levenshtein/empty strings" {
  inspect(normalized_levenshtein("", ""), content="1")
}

///|
test "normalized_levenshtein/equal strings" {
  inspect(normalized_levenshtein("abc", "abc"), content="1")
}

///|
test "normalized_levenshtein/completely different" {
  inspect(normalized_levenshtein("abc", "xyz"), content="0")
}

///|
test "unicode/levenshtein" {
  inspect(levenshtein("日本語", "日本人"), content="1")
}
