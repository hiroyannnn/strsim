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
