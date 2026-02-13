#import "../src/quantity.typ": *

#{
  // integers
  assert.eq(decimal-info("0."), (figures: 0, places: 0))
  // floating points
  assert.eq(decimal-info("0.0"), (figures: 0, places: 1))
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

#import "../src/utils.typ": *

0.000 002 858 => #figures-rounder(0.000002858, digits: 4) \
10 989 000 00 => #figures-rounder(1098900000, digits: 4)
#let value = 0.00003 + 0.0001

#_prepare(value, round-mode: "places") \
#_prepare(value, round-mode: "places", places: 3) \
#_prepare(value, round-mode: "figures", figures: 1) \
