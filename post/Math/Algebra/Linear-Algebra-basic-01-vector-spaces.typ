#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Linear Algebra (1): Vector Spaces")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content, font: "C059", size: 12pt)
#show: set page(
  fill: color.background,
  numbering: "1"
)
#show link: it => {
  set text(fill: color.content-reference-link)
  it
}
#show math.equation.where(block: true): set text(size: 14pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = Linear Algebra (1): Vector Spaces
])

= 1 $RR^n$ and $CC ^n$

= 1.1 Complex Numbers

Complex numbers were invented so that we can take square root of negative numbers.
The idea is to assume that we have a square root of $-1$, denoted as $upright(i)$,
and that obeys the usual rules of arithmetic.

#definition(number: "1")[
  - A *complex number* is an ordered pair $(a,b)$, where $a,b in RR$, we will write
    this as $a+b upright(i)$.
  - The set of all complex numbers is denoted by $CC$:

    $ CC={a+b upright(i) : a,b in RR}  $

  - *Addition* and *multiplication* on $CC$ are defined by

    $ (a+b upright(i))+(c+d upright(i)) & = (a+c)+(b+d) upright(i) \
    (a+b upright(i))(c+d upright(i)) & = (a c-b d)+(a d + b c) upright(i) $

    here $a,b,c,d in RR$.
]

If $a in RR$, we identify
