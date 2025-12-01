#import "utils.typ"

/// Parser for unit input
/// The possible patterns:
/// - " " is used for separating units
/// - "/" is used as a prefix for inverting unit exponent
/// - "^" is used for unit exponent
/// - "^-1" is possible
/// - "1/s" is possible
/// Output: a tuples of length two for which the first element is the unit and the second element is the exponent.
#let _parse-a-unit(u, is-denom: false) = {
  let splitted = u.split("^")
  assert(splitted.len() <= 2, message: "Each unit must have one, integer exponent.")
  let name = splitted.first()
  let exponent

  if splitted.len() == 2 {
    exponent = eval(splitted.last())
  } else {
    exponent = 1
  }

  if is-denom {
    exponent = -exponent
  }
  (name, exponent)
}

#let _parse-string-unit(string, sep: " ") = {
  let splitted = string.split("/")
  let noms = ""
  let denoms = ""
  assert(splitted.len() <= 2, message: "Slash as prefix for denominator must not be used more than once.")
  if splitted.len() == 2 {
    (noms, denoms) = splitted
  } else {
    (noms,) = splitted
  }
  let arr-noms = noms.split(sep).map(_parse-a-unit)
  let arr-denoms = denoms.split(sep).map(_parse-a-unit.with(is-denom: true))

  arr-noms + arr-denoms
}

#let parse-unit(string, sep: " ") = {
  let results = (:)
  let short-hands = ("oC": $degree C$, "oF": $degree F$, "oR": $degree R$)
  for (name, exp) in _parse-string-unit(string, sep: sep) {
    if name not in ("1", "") and exp != 0 {
      if name not in results {
        results.insert(name, exp)
      } else {
        results.at(name) += exp
      }
    }
  }
  results
    .pairs()
    .map(((n, e)) => {
      if n in short-hands {
        (short-hands.at(n), e)
      } else {
        (n, e)
      }
    })
}

/// The formatting functionality is provided by zero package.
#import "@preview/zero:0.5.0" as zero: zi

#let quantity(
  value,
  rounder: it => it,
  ..args,
  unit-sep: " ",
  places: auto,
  figures: auto,
  round-mode: "places",
  method: auto,
) = {
  let formatting = args.named()
  let arr-units = args.pos()


  // Extract information about rounding
  value = str(value)
  let (mantissa, exp) = (value, "")
  let (integer, dec) = (value, "")
  if value.contains("e") {
    (mantissa, exp) = value.split("e")
  }
  if mantissa.contains(".") {
    (integer, dec) = mantissa.split(".")
  }

  if figures == auto {
    figures = integer.len() + dec.len()
    if value.contains("-") {
      figures -= 1
    }
  }
  if places == auto {
    places = dec.len()
  }

  let digits = if round-mode == "places" { places } else { figures }

  let qty = zero.num
  let value = rounder(value)

  let units = ()
  if arr-units.len() >= 1 {
    for u in arr-units {
      if type(u) == str {
        units += parse-unit(u, sep: unit-sep)
      } else if type(u) == array {
        assert(u.len() == 2, message: "The custom unit in an array must be in the form `(unit, exponent)`.")
        units.push(u)
      } else {
        units.push((u, 1))
      }
    }
    qty = zi.declare(..units)
  }

  let default-format = (
    round: (mode: round-mode, precision: digits),
  )
  
  let display = qty(value, ..default-format, ..formatting)
  if method == auto {
    method = display
  }
  (
    arr-units: arr-units,
    value: eval(value),
    unit: units,
    places: places,
    figures: figures,
    "show": zero.num(value, ..default-format, ..formatting),
    "text": str(value),
    display: display,
    method: method,
  )
}

#let _get(prop, ..qnts) = {
  qnts.pos().map(q => q.at(prop))
}

#let set-quantity(q, ..formatting) = quantity(..q, ..formatting)