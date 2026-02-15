#import "../export.typ": * 
#import "../src/utils.typ": * 


// #let f1 = x => x * x 
// #let df1 = derivative.with(func: f1)
// #let if1 = x => integrate(-1, x, func: f1)

// #import "@preview/lilaq:0.5.0" as lq 
// #let xs = lq.arange(-1, 1, step: 0.001)
// #let plot = lq.plot.with(mark: none)

// #lq.diagram(
//   plot(xs, df1),
//   plot(xs, f1), 
// )

// #if1(1)
// #let func1 = x => x * x + 2 * x + 1

// #newton-solver(func1)


// #let K = quantity("15.0")
// #let c0 = quantity("1.0", "M")
// #let ep = calculation.div(c0, exact(2))
// #let func(e) = {
//   import calculation: * 
//   sub(mul(K, sub(c0, e)), e)
// }

// // #let a = calculation.solver(
// //   func, init: ep
// // )

// // #a 

// // #a.display

// #set-quantity(ep, value: 2).display

// #let a = quantity("0.24", "m")
// #a
// #calculation.neg(a)

#let A = quantity("1.50e4", "1/s")
#let Ea = quantity("50e3", "J/mol")
#let R = quantity("8.314", "J/mol K")
#let T = quantity("298", "K")

Arrhenius equation is given by
$ k = A e^(-E_a/(R T)) $
This $k$, at $A = #A.display$, $E_a = #Ea.display$, and $T = #T.display$, we have
#let k = {
  import calculation: *
  mul(A, 
  exp(
    div(
      neg(Ea),
      mul(R, T)
    )
  )
  )
}
$ 
  k &= #k.method \ 
    &= #k.display 
$
#k

#import "../src/utils.typ": figures-rounder

// #let figures-rounder(number, digits: 1) = {
//   let magnitude = if number == 0 { 0 } else { calc.floor(calc.log(base: 10, calc.abs(number))) }
//   let A = number / calc.pow(10, magnitude)
//   let rounded-A = calc.round(A, digits: digits - 1)
//   return calc.round(rounded-A * calc.pow(10, magnitude), digits: calc.abs(magnitude) + digits - 1)
// }

#figures-rounder(calc.pow(calc.e, -20), digits: 3)

#calculation.exp(exact(-20), figures: 3)