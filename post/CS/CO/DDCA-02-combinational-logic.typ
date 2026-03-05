#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/circuiteria:0.2.0"
#import "@preview/zap:0.4.0"
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "DDCA (2): Combinational Logic")
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
#show figure.caption: set text(size: 9pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = DDCA (2): Combinational Logic
])

= 1 Introduction

Digital circuits are classified:
- *Combinational logic*, it combines different gates as a circuit, and the
  output won't affect the input. A combinational logic circuit's outputs only
  depend on the current values to compute the output. So *it's memoryless*.
- *Sequential logic*, its outputs depend both on current and previous values of
  the inputs. It depends on the input sequence. And *it has memory*.

*Bus* using a single line with a slash through it, and it represents a bundle of
multiple signals.

= 2 Boolean Equations

#definition(number: "1.1")[
  + *Complement* of $sans("true")$ is $sans("false")$, and complement of $sans("false")$
    is $sans("true")$. If $A$ is a Boolean variable, then we use $overline(A)$
    to denote its complement;
  + *Product* of multiple Boolean variables is
]
