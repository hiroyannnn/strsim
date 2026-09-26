///|
test "sorensen_dice/web applications" {
  let result = @lib.sorensen_dice("web applications", "applications of the web")
  assert_true(result > 0.787 && result < 0.789)
}

///|
test "sorensen_dice/empty strings" {
  inspect(@lib.sorensen_dice("", ""), content="1")
}

///|
test "sorensen_dice/one empty" {
  inspect(@lib.sorensen_dice("a", ""), content="0")
  inspect(@lib.sorensen_dice("", "a"), content="0")
}

///|
test "sorensen_dice/identical" {
  inspect(@lib.sorensen_dice("abc", "abc"), content="1")
}

///|
test "sorensen_dice/single char" {
  inspect(@lib.sorensen_dice("a", "b"), content="0")
}

///|
test "unicode/sorensen_dice" {
  inspect(
    @lib.sorensen_dice("日本語テスト", "日本語テスト"),
    content="1",
  )
}
