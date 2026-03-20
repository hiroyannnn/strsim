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
test "unicode/hamming" {
  inspect(try? hamming("あいう", "あいえ"), content="Ok(1)")
}
