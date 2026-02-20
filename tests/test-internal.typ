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

= Rounder 
0.000 002 858 => #figures-rounder(0.000002858, digits: 4) \
10 989 000 00 => #figures-rounder(1098900000, digits: 4)
#let value = 0.00003 + 0.0001

= `#_prepare`
#_prepare(value, round-mode: "places") \
#_prepare(value, round-mode: "places", places: 3) \
#_prepare(value, round-mode: "figures", figures: 1) \ 
#_prepare(calc.pi, round-mode: auto, figures: 4) \

= `#_resolve-units`
#_resolve-units("M") \
#_resolve-units(("M",)) \
#_resolve-units(("M", 2)) \
#_resolve-units((("M", 2),)) \
#_resolve-units((("M", 2), "B")) \
#_resolve-units((("M", 2), ("B", -1))) \
#_resolve-units("M/K^2") \
#_resolve-units(("M", "1/K^2")) \
#_resolve-units((("M", 3), "1/K^2")) \
#_resolve-units(()) \
#_resolve-units("") \

= `#_resolve-round-mode`
#_resolve-round-mode("12e3") \
#_resolve-round-mode("1") \
#_resolve-round-mode("200") \
#_resolve-round-mode("0.0003") \
#_resolve-round-mode("0") \
#_resolve-round-mode("1.120") \

= `#_make-quantity`
== raw 
#_make-quantity(value: 0) \
#_make-quantity(value: 0.000000023452) \
#_make-quantity(value: 0.002) \
#_make-quantity(value: 200) \
#_make-quantity(value: "0.020") \
#_make-quantity(value: "2e4") \
#_make-quantity(value: "6.02e-23") \
#_make-quantity(value: calc.pi, figures: 4)

== display 
#_make-quantity(value: 0).display \
#_make-quantity(value: 0.000000023452).display \
#_make-quantity(value: 0.002).display \
#_make-quantity(value: 200).display \
#_make-quantity(value: "0.020").display \
#_make-quantity(value: "2e4").display \
#_make-quantity(value: "6.02e-23").display \
#_make-quantity(value: calc.pi, figures: 4).display

== `#_make-exact` 
#_make-exact(value: calc.pi)