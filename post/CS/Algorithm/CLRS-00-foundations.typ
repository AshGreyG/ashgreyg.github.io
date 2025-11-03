#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (0): Foundations")
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
  = CLRS (0): Foundations
])

= 1 Divide-and-Conquer Approach

Many useful algorithms are *recursive* in structure, to solve a given problem,
they call themselves one or more times to deal with closely related subproblems.
These algorithms typically follow a *divide-and-conquer* approach: they break
the problem into several subproblems that are similar to the original problem
but smaller in size, finally combine these solutions to the original problem.

== 1.1 Example: Merge Sort

== 1.2 Master Theorem

The master theorem provides a solution for recurrence relations of the form

$ T(n) = a T(n / b) + f(n) $

where:
- $a ≥ 1$, number of subproblems,
- $b > 1$, factor which the problem size is reduced,
- $f(n)$ is asymptotically
