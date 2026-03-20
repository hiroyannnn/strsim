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

///|
test "osa_distance/ac-cba" {
  inspect(osa_distance("ac", "cba"), content="3")
}

///|
test "osa_distance/kitten-sitting" {
  inspect(osa_distance("kitten", "sitting"), content="3")
}

///|
test "osa_distance/empty strings" {
  inspect(osa_distance("", ""), content="0")
}

///|
test "osa_distance/one empty" {
  inspect(osa_distance("", "abc"), content="3")
  inspect(osa_distance("abc", ""), content="3")
}

///|
test "osa_distance/equal strings" {
  inspect(osa_distance("abc", "abc"), content="0")
}

///|
test "osa_distance/transposition" {
  inspect(osa_distance("ab", "ba"), content="1")
}

///|
test "damerau_levenshtein/ac-cba" {
  inspect(damerau_levenshtein("ac", "cba"), content="2")
}

///|
test "damerau_levenshtein/kitten-sitting" {
  inspect(damerau_levenshtein("kitten", "sitting"), content="3")
}

///|
test "damerau_levenshtein/empty strings" {
  inspect(damerau_levenshtein("", ""), content="0")
}

///|
test "damerau_levenshtein/one empty" {
  inspect(damerau_levenshtein("", "abc"), content="3")
  inspect(damerau_levenshtein("abc", ""), content="3")
}

///|
test "damerau_levenshtein/equal strings" {
  inspect(damerau_levenshtein("abc", "abc"), content="0")
}

///|
test "damerau_levenshtein/transposition" {
  inspect(damerau_levenshtein("ab", "ba"), content="1")
}

///|
test "osa vs damerau_levenshtein" {
  // OSA: restricted (each substring edited at most once) → 3
  // DL: unrestricted (true metric) → 2
  inspect(osa_distance("ac", "cba"), content="3")
  inspect(damerau_levenshtein("ac", "cba"), content="2")
}

///|
test "sorensen_dice/web applications" {
  let result = sorensen_dice("web applications", "applications of the web")
  assert_true(result > 0.787 && result < 0.789)
}

///|
test "sorensen_dice/empty strings" {
  inspect(sorensen_dice("", ""), content="1")
}

///|
test "sorensen_dice/one empty" {
  inspect(sorensen_dice("a", ""), content="0")
  inspect(sorensen_dice("", "a"), content="0")
}

///|
test "sorensen_dice/identical" {
  inspect(sorensen_dice("abc", "abc"), content="1")
}

///|
test "sorensen_dice/single char" {
  inspect(sorensen_dice("a", "b"), content="0")
}

///|
test "lcs_length/ABCD-ACBAD" {
  inspect(lcs_length("ABCD", "ACBAD"), content="3")
}

///|
test "lcs_length/empty strings" {
  inspect(lcs_length("", ""), content="0")
}

///|
test "lcs_length/one empty" {
  inspect(lcs_length("", "abc"), content="0")
  inspect(lcs_length("abc", ""), content="0")
}

///|
test "lcs_length/equal strings" {
  inspect(lcs_length("abc", "abc"), content="3")
}

///|
test "lcs_length/no common" {
  inspect(lcs_length("abc", "xyz"), content="0")
}
