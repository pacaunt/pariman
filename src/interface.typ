#import "quantity.typ" as q

#let _all-quantities = state("_pariman:0.2.0_local_quantities", (:))

#let _declare(name, value, ..args) = {
  let update = it => it
  let quantity = none

  if type(value) == dictionary {
    update = dict => dict + ((name): value)
    quantity = value
  } else if type(value) == function {
    update = dict => {
      dict.insert(name, value(dict))
      dict
    }
    quantity = auto
  } else {
    quantity = q.quantity(value, ..args)
    update = dict => dict + ((name): quantity)
  }
  return (update: update, quantity: quantity, name: name)
}

#let new(
  // name of the value
  name,
  // the value
  value,
  // the units and properties of the quantity.
  ..args,
  displayed: true,
) = {
  let (quantity, name, update) = _declare(name, value, ..args)
  _all-quantities.update(update)
  if displayed {
    if quantity == auto { context _all-quantities.get().at(name).display } else { quantity.display }
  }
}

#let register = new.with(displayed: false)

#let clear() = _all-quantities.update((:))

// calculate some value or modify the quantity that has a name specified by `key`.
#let update(key, func) = _all-quantities.update(dict => {
  let result = func(dict)
  if key in dict.keys() {
    dict.at(key) = result
  } else {
    dict.insert(key, result)
  }
  return dict
})

#let set-property(key, ..properties) = _all-quantities.update(dict => {
  let target = dict.at(key)
  dict.at(key) = q.set-quantity(target, ..properties)
  return dict
})

#let display(key) = context _all-quantities.get().at(key).display
#let method(key) = context _all-quantities.get().at(key).method

// contextual
#let get(key: auto) = {
  if key == auto {
    _all-quantities.get()
  } else {
    _all-quantities.get().at(key)
  }
}
