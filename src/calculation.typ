#import "quantity.typ": quantity
#import "converter.typ": invert-unit, multiply-unit, operate-unit, power-unit, root-unit
#let _get(prop, ..qnts) = {
  qnts.pos().map(q => q.at(prop))
}

#let add(..qnts) = {
  let formatting = qnts.named()
  let qnts = qnts.pos()
  let units = _get("unit", ..qnts)
  let values = _get("value", ..qnts)
  let places = _get("places", ..qnts)
  assert(units.all(i => i == qnts.first().unit), message: "Adding quantities only allow for the same units.")
  let result = values.sum()
  let new-places = calc.min(..places)
  quantity(
    result,
    ..units.at(0),
    places: new-places,
    round-mode: "places",
    ..formatting,
  )
}

#let sub(q1, q2, ..formatting) = {
  let (v1, v2) = _get("value", q1, q2)
  let (u1, u2) = _get("unit", q1, q2)
  assert(u1 == u2, message: "Subtraction requires quantities in the same unit.")
  let places = _get("places", q1, q2)
  let result = v1 - v2
  let new-places = calc.min(..places)
  quantity(
    str(result),
    ..u1,
    places: new-places,
    round-mode: "places",
    ..formatting,
  )
}

#let mul(..qnts) = {
  let formatting = qnts.named()
  let qnts = qnts.pos()
  let values = _get("value", ..qnts)
  let units = _get("unit", ..qnts).sum()
  let figures = _get("figures", ..qnts)
  let new-figures = calc.min(..figures)
  let new-units = multiply-unit(..units)
  quantity(
    str(values.product()),
    ..new-units,
    figures: new-figures,
    round-mode: "figures",
    ..formatting,
  )
}

#let inv(qnt, ..formatting) = {
  let (value, unit, figures) = qnt
  let new-unit = invert-unit(..unit)
  quantity(
    str(1 / value),
    ..new-unit,
    figures: figures,
    round-mode: "figures",
    ..formatting,
  )
}

#let div(q1, q2, ..formatting) = {
  let (v1, v2) = _get("value", q1, q2)
  let (u1, u2) = _get("unit", q1, q2)
  let new-unit = multiply-unit(..u1, ..invert-unit(..u2))
  let figures = _get("figures", q1, q2)
  let new-figures = calc.min(..figures)
  quantity(
    str(v1 / v2),
    ..new-unit,
    figures: new-figures,
    round-mode: "figures",
    ..formatting,
  )
}

#let pow(q1, q2, ..formatting) = {
  let (v1, v2) = _get("value", q1, q2)
  let (u1, u2) = _get("unit", q1, q2)
  let new-value
  let new-unit
  let new-figures = q1.figures
  assert(u2 == (), message: "The exponent must be dimensionless.")
  if type(v2) == int {
    new-value = calc.pow(v1, v2)
    new-unit = power-unit(..u1, v2)
  } else {
    assert(u1 == (), message: "Fractional exponentiation is only allowed for dimensionless quantity.")
    new-value = calc.pow(v1, v2)
    new-unit = ()
    new-figures = q2.places
  }
  quantity(
    str(new-value), 
    ..new-unit, 
    figures: new-figures, 
    round-mode: "figures", 
    ..formatting
  )
}

#let root(qnt, n, ..formatting) = {
  let new-unit = root-unit(..qnt.unit, n)
  quantity(
    str(calc.root(qnt.value, n)), 
    ..new-unit, 
    figures: qnt.figures, 
    round-mode: "figures",
    ..formatting
  )
}

#let log(base: 10, qnt, ..formatting) = {
  let value = qnt.value 
  let unit = qnt.unit 
  assert(unit == (), message: "Logarithms only accept dimensionless quantity.")

  let new-places = qnt.figures
  if type(base) in (int, float) {
    value = calc.log(base: base, value)
  } else {
    assert(base.unit == (), message: "Logarithm's base must be a dimensionless quantity.")
    value = calc.log(base: base.value, value)
  }
  quantity(
    str(value), 
    places: new-places, 
    round-mode: "places", 
    ..formatting
  )
}

#let ln(qnt, ..formatting) = {
  assert(qnt.unit == (), message: "Natural logarithm only accepts dimensionless quantity")
  quantity(
    str(calc.ln(qnt.value)), 
    places: qnt.figures, 
    round-mode: "places", 
    ..formatting
  )
}

#let exp(qnt, ..formatting) = {
  assert(qnt.unit == (), message: "Exponentiation only accepts dimensionless quantity.")
  quantity(
    str(calc.exp(qnt.value)), 
    figures: qnt.places, 
    round-mode: "figures", 
    ..formatting
  )
}



// #let A = quantity("100.5824", "m")
// #let B = quantity("5.363", "m")

// #let C = quantity("1.2e3", "1/kg")

// #add(A, B).display
// #sub(A, B).display

// #mul(A, B).display
// #mul(B, C).display

// #inv(C).display
// #import "@preview/zero:0.5.0": num

// #div(A, B)
// #box(div(A, B).display, stroke: 1pt)

// #pow(A, quantity("2")).display

// #pow(div(A, B), quantity("0.333")).display

// #root(pow(A, quantity("2")), 2).display

// #let pi = quantity(str(calc.pi))
// #let X = quantity("123")

// #log(base: pi, X).display

// #quantity("30", "W/m^2 oC").display

