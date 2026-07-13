#import "../../src/calculation.typ": *
#import "../../src/quantity.typ": *

#set page(width:auto, height: auto, margin:0.5em)
#let a1 = quantity(1, "m")
#let a2 = quantity(10, "m")
#let a3 = quantity(5, "m")
#let s1 = exact(55, "s")

#let add1 = add(a1,a2, method:quantities =>{
  let result
  for i in range(0, quantities.len()) {
    if i != 0{
      if quantities.at(i).value > 0{
        result += $plus$
      }

    }
    result += quantities.at(i).method
  }
  return result
  })
#add1.method = #add1.display

#let value2 = div(add1, s1)

#value2.method = 
#value2.display

#{
  // value2.method = value2.display
}

#let value3 = pow(value2, div(a2, a3))

#value3.method = #value3.display