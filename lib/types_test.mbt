///|
test "distance/Hamming" {
  inspect(@lib.distance(Hamming, "hamming", "hammers"), content="3")
  try @lib.distance(Hamming, "hamming", "ham") catch {
    e => inspect(e, content="UnequalLength")
  } noraise {
    _ => fail("expected distance(Hamming) to raise UnequalLength")
  }
}

///|
test "distance/Levenshtein" {
  inspect(@lib.distance(Levenshtein, "kitten", "sitting"), content="3")
}

///|
test "distance/Osa" {
  inspect(@lib.distance(Osa, "ac", "cba"), content="3")
}

///|
test "distance/DamerauLevenshtein" {
  inspect(@lib.distance(DamerauLevenshtein, "ac", "cba"), content="2")
}

///|
test "similarity/NormalizedLevenshtein" {
  let result = @lib.similarity(NormalizedLevenshtein, "kitten", "sitting")
  assert_true(result > 0.571 && result < 0.572)
}

///|
test "similarity/Jaro" {
  inspect(@lib.similarity(Jaro, "abc", "abc"), content="1")
}

///|
test "similarity/JaroWinkler" {
  let result = @lib.similarity(JaroWinkler, "cheeseburger", "cheese fries")
  assert_true(result > 0.865 && result < 0.867)
}

///|
test "similarity/SorensenDice" {
  inspect(@lib.similarity(SorensenDice, "", ""), content="1")
}
