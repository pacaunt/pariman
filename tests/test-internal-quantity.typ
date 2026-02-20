#import "../src/quantity.typ": * 

#_resolve-units("M") \
#_resolve-units(("M",)) \
#_resolve-units(("M", 2)) \
#_resolve-units((("M", 2),)) \
#_resolve-units((("M", 2), "B")) \
#_resolve-units((("M", 2), ("B", -1))) \
#_resolve-units("M/K^2") \
#_resolve-units(("M", "1/K^2")) \
#_resolve-units((("M", 3), "1/K^2")) \
#_resolve-units(()) \
#_resolve-units("") \