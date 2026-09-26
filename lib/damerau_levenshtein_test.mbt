///|
test "damerau_levenshtein/ac-cba" {
  inspect(@lib.damerau_levenshtein("ac", "cba"), content="2")
}

///|
test "damerau_levenshtein/kitten-sitting" {
  inspect(@lib.damerau_levenshtein("kitten", "sitting"), content="3")
}

///|
test "damerau_levenshtein/empty strings" {
  inspect(@lib.damerau_levenshtein("", ""), content="0")
}

///|
test "damerau_levenshtein/one empty" {
  inspect(@lib.damerau_levenshtein("", "abc"), content="3")
  inspect(@lib.damerau_levenshtein("abc", ""), content="3")
}

///|
test "damerau_levenshtein/equal strings" {
  inspect(@lib.damerau_levenshtein("abc", "abc"), content="0")
}

///|
test "damerau_levenshtein/transposition" {
  inspect(@lib.damerau_levenshtein("ab", "ba"), content="1")
}

///|
test "osa vs damerau_levenshtein" {
  inspect(@lib.osa_distance("ac", "cba"), content="3")
  inspect(@lib.damerau_levenshtein("ac", "cba"), content="2")
}
