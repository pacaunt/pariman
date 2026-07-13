#import "../../src/quantity.typ": quantity, exact, set-quantity

#set page(width:auto, height: auto, margin:0.5em)

#exact(calc.pi, display-figures: 4)

#quantity(calc.pi, figures: 4)

#let Pi = exact(calc.pi)

#set-quantity(Pi, display-figures: 4).display