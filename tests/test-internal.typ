#import "../src/quantity.typ": *

#{
  // integers
  assert.eq(decimal-info("0."), (figures: 1, places: 0))
  // floating points
  assert.eq(decimal-info("0.0"), (figures: 1, places: 1))
  assert.eq(decimal-info("0.01"), (figures: 1, places: 2))
  assert.eq(decimal-info("0.010"), (figures: 2, places: 3))
  assert.eq(decimal-info("0.010"), (figures: 2, places: 3))
  assert.eq(decimal-info("0.011"), (figures: 2, places: 3))
  assert.eq(decimal-info("0.0102"), (figures: 3, places: 4))
  assert.eq(decimal-info("0.01020"), (figures: 4, places: 5))
  assert.eq(decimal-info("1."), (figures: 1, places: 0))
  assert.eq(decimal-info("1.0"), (figures: 2, places: 1))
  assert.eq(decimal-info("10.0"), (figures: 3, places: 1))
  assert.eq(decimal-info("100.0"), (figures: 4, places: 1))
  assert.eq(decimal-info("100.01"), (figures: 5, places: 2))
  // E-notation
  assert.eq(e-notation-info("1e1"), (figures: 1, places: 0))
  assert.eq(e-notation-info("1.0e1"), (figures: 2, places: 0))
  assert.eq(e-notation-info("1.01e1"), (figures: 3, places: 1))
  assert.eq(e-notation-info("0.1e1"), (figures: 1, places: 0))
  assert.eq(e-notation-info("0.01e1"), (figures: 1, places: 1))
}
