#import "../export.typ": * 
#import "../src/utils.typ": * 


#let f1 = x => x * x 
#let df1 = derivative.with(func: f1)
#let if1 = x => integrate(-1, x, func: f1)

#import "@preview/lilaq:0.5.0" as lq 
#let xs = lq.arange(-1, 1, step: 0.001)
#let plot = lq.plot.with(mark: none)

#lq.diagram(
  plot(xs, df1),
  plot(xs, f1), 
)

#if1(1)
#let func1 = x => x * x + 2 * x + 1

#newton-solver(func1)


#let K = quantity("15.0")
#let c0 = quantity("1.0", "M")
#let ep = calculation.div(c0, exact(2))
#let func(e) = {
  import calculation: * 
  sub(mul(K, sub(c0, e)), e)
}

#let a = calculation.solver(
  func, init: ep
)

#a 

#a.display

#set-quantity(ep, value: 2).display

#let a = quantity("0.24", "m")
#a
#calculation.neg(a)

