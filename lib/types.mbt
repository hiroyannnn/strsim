///|
pub(all) suberror StrsimError {
  UnequalLength
}

///|
pub impl Show for StrsimError with output(self, logger) {
  match self {
    UnequalLength => logger.write_string("UnequalLength")
  }
}

///|
pub(all) enum DistanceMetric {
  Hamming
  Levenshtein
  Osa
  DamerauLevenshtein
}

///|
pub(all) enum SimilarityMetric {
  NormalizedLevenshtein
  Jaro
  JaroWinkler
  SorensenDice
}

///|
pub fn distance(
  metric : DistanceMetric,
  a : String,
  b : String,
) -> Int raise StrsimError {
  match metric {
    Hamming => hamming(a, b)
    Levenshtein => levenshtein(a, b)
    Osa => osa_distance(a, b)
    DamerauLevenshtein => damerau_levenshtein(a, b)
  }
}

///|
pub fn similarity(metric : SimilarityMetric, a : String, b : String) -> Double {
  match metric {
    NormalizedLevenshtein => normalized_levenshtein(a, b)
    Jaro => jaro(a, b)
    JaroWinkler => jaro_winkler(a, b)
    SorensenDice => sorensen_dice(a, b)
  }
}
