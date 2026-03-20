///|
test "distance/Hamming" {
  inspect(try? distance(Hamming, "hamming", "hammers"), content="Ok(3)")
  inspect(
    try? distance(Hamming, "hamming", "ham"),
    content="Err(UnequalLength)",
  )
}

///|
test "distance/Levenshtein" {
  inspect(try? distance(Levenshtein, "kitten", "sitting"), content="Ok(3)")
}

///|
test "distance/Osa" {
  inspect(try? distance(Osa, "ac", "cba"), content="Ok(3)")
}

///|
test "distance/DamerauLevenshtein" {
  inspect(try? distance(DamerauLevenshtein, "ac", "cba"), content="Ok(2)")
}

///|
test "similarity/NormalizedLevenshtein" {
  let result = similarity(NormalizedLevenshtein, "kitten", "sitting")
  assert_true(result > 0.571 && result < 0.572)
}

///|
test "similarity/Jaro" {
  inspect(similarity(Jaro, "abc", "abc"), content="1")
}

///|
test "similarity/JaroWinkler" {
  let result = similarity(JaroWinkler, "cheeseburger", "cheese fries")
  assert_true(result > 0.865 && result < 0.867)
}

///|
test "similarity/SorensenDice" {
  inspect(similarity(SorensenDice, "", ""), content="1")
}
