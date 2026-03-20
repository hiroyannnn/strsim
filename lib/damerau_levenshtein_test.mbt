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
  inspect(osa_distance("ac", "cba"), content="3")
  inspect(damerau_levenshtein("ac", "cba"), content="2")
}
