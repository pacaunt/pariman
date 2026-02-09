#import "quantity.typ" as q

#let _all-quantities = state("_pariman:0.2.0", (:))

#let new(
  // name of the value
  name,
  // the value
  value,
  // the units and properties of the quantity.
  ..args,
) = {
  let qnt = q.quantity(value, ..args)
  _all-quantities.update(info => info + ((name): qnt))
  qnt.display
}

#let clear = _all-quantities.update((:))

// calculate some value or modify the quantity that has a name specified by `key`.
#let update(key, func) = _all-quantities.update(dict => {
  assert(key in dict.keys(), message: "unknown quantity name " + repr(key) + ".")
  dict.at(key) = func(dict)
  return dict
})

#let display(key) = context _all-quantities.get().at(key).display

// contextual
#let get(key: auto) = {
  if key == auto {
    _all-quantities.get()
  } else {
    _all-quantities.get().at(key)
  }
}