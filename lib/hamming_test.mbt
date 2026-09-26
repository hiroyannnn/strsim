///|
test "hamming/basic" {
  inspect(@lib.hamming("hamming", "hammers"), content="3")
}

///|
test "hamming/unequal length" {
  try @lib.hamming("hamming", "ham") catch {
    e => inspect(e, content="UnequalLength")
  } noraise {
    _ => fail("expected hamming to raise UnequalLength")
  }
}

///|
test "hamming/empty strings" {
  inspect(@lib.hamming("", ""), content="0")
}

///|
test "hamming/identical" {
  inspect(@lib.hamming("abc", "abc"), content="0")
}

///|
test "unicode/hamming" {
  inspect(@lib.hamming("あいう", "あいえ"), content="1")
}
