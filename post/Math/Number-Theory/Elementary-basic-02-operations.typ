#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Real Analysis (1): Number Systems")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#show: set page(
  fill: color.background,
  numbering: "1"
)
#show link: it => {
  set text(fill: color.content-reference-link)
  it
}

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = Elementary Number Theory (2): Operations
])

= 1 Representation of Integers

