#import "docs.typ": * 
#set page(height: auto, margin: 0.5cm)
#place(hide(include "content.typ"))

#context {
  let examples = query(raw.where(lang: "example"))
  examples.map(it => eval-example(it.text)).intersperse(pagebreak())
    .join()
}