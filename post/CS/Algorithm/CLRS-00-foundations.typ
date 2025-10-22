#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (0): Foundations")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#set page(fill: color.background)

#align(center, text(17pt)[
  = CLRS (0): Foundations
])

= 1 Master Theorem

The master theorem provides a solution for recurrence relations of the form

$ T(n) = a T(n / b) + f(n) $

where:
- $a ≥ 1$, number of subproblems,
- $b > 1$, factor which the problem size is reduced,
- $f(n)$ is asymptotically