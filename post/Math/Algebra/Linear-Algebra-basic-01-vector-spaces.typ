#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Linear Algebra (1): Vector Spaces")

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", fill: rgb("#e8e8f8"))

#let proof = thmproof("proof", "Proof")

// I don't know why letting ctheorems package in a separate file 
// will lead to the centered theorem environment

/////////////////////////////////////////////

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
