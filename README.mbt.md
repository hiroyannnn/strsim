# hiroyannnn/strsim

String similarity algorithms for [MoonBit](https://www.moonbitlang.com/), inspired by [strsim-rs](https://github.com/rapidfuzz/strsim-rs).

## Installation

```
moon add hiroyannnn/strsim
```

## Usage

### Distance metrics

```mbt
///|
test "Hamming distance" {
  inspect(try? @strsim.hamming("hamming", "hammers"), content="Ok(3)")
  inspect(try? @strsim.hamming("hamming", "ham"), content="Err(UnequalLength)")
}

///|
test "Levenshtein distance" {
  inspect(@strsim.levenshtein("kitten", "sitting"), content="3")
}

///|
test "OSA distance" {
  inspect(@strsim.osa_distance("ac", "cba"), content="3")
}

///|
test "Damerau-Levenshtein distance" {
  inspect(@strsim.damerau_levenshtein("ac", "cba"), content="2")
}

///|
test "LCS length" {
  inspect(@strsim.lcs_length("ABCD", "ACBAD"), content="3")
}
```

### Similarity metrics

```mbt
///|
test "Normalized Levenshtein" {
  let result = @strsim.normalized_levenshtein("kitten", "sitting")
  // 1.0 - 3/7 ≈ 0.571
  assert_true(result > 0.571 && result < 0.572)
}

///|
test "Jaro similarity" {
  let result = @strsim.jaro("Friedrich Nietzsche", "Jean-Paul Sartre")
  assert_true(result > 0.391 && result < 0.393)
}

///|
test "Jaro-Winkler similarity" {
  let result = @strsim.jaro_winkler("cheeseburger", "cheese fries")
  assert_true(result > 0.865 && result < 0.867)
}

///|
test "Sørensen-Dice coefficient" {
  let result = @strsim.sorensen_dice(
    "web applications", "applications of the web",
  )
  assert_true(result > 0.787 && result < 0.789)
}
```

### Enum dispatch

```mbt
///|
test "distance dispatch" {
  inspect(
    try? @strsim.distance(@strsim.Levenshtein, "kitten", "sitting"),
    content="Ok(3)",
  )
}

///|
test "similarity dispatch" {
  inspect(@strsim.similarity(@strsim.Jaro, "abc", "abc"), content="1")
}
```

## Algorithm comparison

### OSA vs Damerau-Levenshtein

OSA restricts each substring to be edited at most once (not a true metric).
Damerau-Levenshtein has no such restriction (true metric, satisfies triangle inequality).

```mbt
///|
test "OSA vs DL" {
  // "ac" → "cba": OSA needs 3 ops, DL needs only 2
  inspect(@strsim.osa_distance("ac", "cba"), content="3")
  inspect(@strsim.damerau_levenshtein("ac", "cba"), content="2")
}
```

## API reference

| Function | Signature | Description |
|---|---|---|
| `hamming` | `(String, String) -> Int raise StrsimError` | Hamming distance (equal length only) |
| `levenshtein` | `(String, String) -> Int` | Levenshtein distance |
| `normalized_levenshtein` | `(String, String) -> Double` | Normalized Levenshtein (0.0–1.0) |
| `osa_distance` | `(String, String) -> Int` | Optimal String Alignment distance |
| `damerau_levenshtein` | `(String, String) -> Int` | Damerau-Levenshtein distance (true metric) |
| `jaro` | `(String, String) -> Double` | Jaro similarity |
| `jaro_winkler` | `(String, String, prefix_weight? : Double) -> Double` | Jaro-Winkler similarity (weight clamped to [0.0, 0.25]) |
| `sorensen_dice` | `(String, String) -> Double` | Sørensen-Dice coefficient |
| `lcs_length` | `(String, String) -> Int` | Longest Common Subsequence length |
| `distance` | `(DistanceMetric, String, String) -> Int raise StrsimError` | Dispatch by enum |
| `similarity` | `(SimilarityMetric, String, String) -> Double` | Dispatch by enum |

## Cross-language comparison

| Algorithm | strsim (MoonBit) | strsim-rs (Rust) | strsimpy (Python) |
|---|---|---|---|
| Hamming | `hamming` | `hamming` | `Hamming().distance` |
| Levenshtein | `levenshtein` | `levenshtein` | `Levenshtein().distance` |
| Normalized Levenshtein | `normalized_levenshtein` | `normalized_levenshtein` | `NormalizedLevenshtein().similarity` |
| OSA | `osa_distance` | `osa_distance` | `OptimalStringAlignment().distance` |
| Damerau-Levenshtein | `damerau_levenshtein` | `damerau_levenshtein` | `DamerauLevenshtein().distance` |
| Jaro | `jaro` | `jaro` | `Jaro().similarity` |
| Jaro-Winkler | `jaro_winkler` | `jaro_winkler` | `JaroWinkler().similarity` |
| Sørensen-Dice | `sorensen_dice` | `sorensen_dice` | `SorensenDice().similarity` |
| LCS | `lcs_length` | — | `LongestCommonSubsequence().distance` |

## License

Apache-2.0
