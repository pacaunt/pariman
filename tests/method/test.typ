#import "../../src/calculation.typ": *
#import "../../src/quantity.typ": *

#set page(width:auto, height: auto, margin:0.5em)
#let a1 = quantity(1, "m", error:0.1)
#let a2 = quantity(10, "m", error:0.2)
#let a3 = quantity(5, "m")
#let s1 = exact(55, "s")

#let add1 = add(a1, a2, round:(precision:6))
#add1.method = #add1.display

#add1.error-method = #add1.error-display
#let add1 = quantity(11, "m", error:.16)


#let value2 = div(add1, s1)
#value2.method = #value2.display

#value2.error-method = #value2.error-display

#{
  // value2.method = value2.display
}

#let value3 = pow(value2, div(a2, a3))

#value3.method = #value3.display

#value3.error-method = #value3.error-display