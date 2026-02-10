#import "../src/calculation.typ": * 
#import "../export.typ": *

= Integers 
#let a1 = quantity("1", "m")
#let a2 = quantity("10", "m")
#let a3 = quantity("100", "m")
#let a4 = quantity("-1", "m")
#let a5 = quantity("-10", "m")
#let a6 = quantity("-100", "m")

#a1.display \
#a2.display \
#a3.display \
#a4.display \
#a5.display \
#a6.display \

== Add
#let add1 = calculation.add(a1, a2)
#add1.method = #add1.display

#let add2 = calculation.add(add1, a4)
#add2.method = #add2.display

== Neg 
#let neg1 = calculation.neg(add1)
#neg1.method = #neg1.display

// floating points
#let f1 = quantity("1.10", "kg/m3")
#let f2 = quantity("0.120")

#let e1 = quantity("1.0e2", "m")
#let e2 = quantity("1.5e-3", "m")
#let e3 = quantity("-2.0e3", "m")

#let e-add1 = calculation.add(e1, e2)
#e-add1.method = #e-add1.display

#let e-mul1 = calculation.mul(e1, e2)
#e-mul1.method = #e-mul1.display

#let e-pow1 = calculation.pow(e2, exact(3))
#e-pow1.method = #e-pow1.display

#let const-pi = exact(calc.pi, display-figures: 4)

#let radius = quantity("1.20", "cm")
#let area = {
  import calculation: * 
  mul(const-pi, pow(radius, exact(2)))
}

#area.method = #area.display

#let m-km = new-factor(
  quantity("1", "m"), 
  exact("1000", "km")
) 

#let length-km = calculation.mul(a1, m-km.inv)

#length-km.method = #length-km.display

#let pi = exact(calc.pi)
#let pi = set-quantity(pi, display-figures: 3)
#pi.display

#let pi = exact(calc.pi, display-figures: 3)
#pi.display

// positive exponent
// negative exponent
// very large number
// very small number
// significant numbers
// decimal places
// addition
// subtraction
// multiplication
// division
// inversion
// logarithm
// natural logarithm
// exponentiation
// power
// root
// newton-solver