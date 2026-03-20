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
