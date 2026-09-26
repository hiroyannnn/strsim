///|
test "osa_distance/ac-cba" {
  inspect(@lib.osa_distance("ac", "cba"), content="3")
}

///|
test "osa_distance/kitten-sitting" {
  inspect(@lib.osa_distance("kitten", "sitting"), content="3")
}

///|
test "osa_distance/empty strings" {
  inspect(@lib.osa_distance("", ""), content="0")
}

///|
test "osa_distance/one empty" {
  inspect(@lib.osa_distance("", "abc"), content="3")
  inspect(@lib.osa_distance("abc", ""), content="3")
}

///|
test "osa_distance/equal strings" {
  inspect(@lib.osa_distance("abc", "abc"), content="0")
}

///|
test "osa_distance/transposition" {
  inspect(@lib.osa_distance("ab", "ba"), content="1")
}
