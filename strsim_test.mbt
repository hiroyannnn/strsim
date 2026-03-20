///|
test "hamming/basic" {
  inspect(try? hamming("hamming", "hammers"), content="Ok(3)")
}

///|
test "hamming/unequal length" {
  inspect(try? hamming("hamming", "ham"), content="Err(UnequalLength)")
}

///|
test "hamming/empty strings" {
  inspect(try? hamming("", ""), content="Ok(0)")
}

///|
test "hamming/identical" {
  inspect(try? hamming("abc", "abc"), content="Ok(0)")
}

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
  // 1.0 - 3/7 ≈ 0.5714285714285714
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
