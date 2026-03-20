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
