///|
test "lcs_length/ABCD-ACBAD" {
  inspect(@lib.lcs_length("ABCD", "ACBAD"), content="3")
}

///|
test "lcs_length/empty strings" {
  inspect(@lib.lcs_length("", ""), content="0")
}

///|
test "lcs_length/one empty" {
  inspect(@lib.lcs_length("", "abc"), content="0")
  inspect(@lib.lcs_length("abc", ""), content="0")
}

///|
test "lcs_length/equal strings" {
  inspect(@lib.lcs_length("abc", "abc"), content="3")
}

///|
test "lcs_length/no common" {
  inspect(@lib.lcs_length("abc", "xyz"), content="0")
}
