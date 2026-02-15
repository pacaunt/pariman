#import "../export.typ" as pariman: *
#import "@preview/zebraw:0.6.1": zebraw

#let eval-example = eval.with(mode: "markup", scope: dictionary(pariman))
#let info = toml("../typst.toml").package

#let template(body) = {
  set page(numbering: "1")
  set text(font: "New Computer Modern")

  show math.equation: set text(weight: 400)
  show link: set text(fill: blue)
  show link: underline
  show raw: set text(font: "JetBrainsMono NF")
  show raw.where(block: false): box
  set heading(numbering: "1.1")

  show: zebraw
  show raw.where(lang: "example"): it => {
    set block(breakable: false)
    grid(
      columns: (1fr,) * 2,
      column-gutter: 1em,
      raw(lang: "typst", it.text, block: true),
      {
        set text(font: "New Computer Modern")
        eval-example(it.text)
      },
    )
  }

  align(center)[
    #title(info.name)
    v#info.version \
    #link("https://github.com/pacaunt/pariman") \
    #info.description
  ]

  outline(depth: 2)
  body
}
