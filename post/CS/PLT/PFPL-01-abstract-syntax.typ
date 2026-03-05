#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "PFPL (1): Abstract Syntax")
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
  = PFPL (1): Abstract Syntax
])

The informal concept of syntax involves several distinct concepts.

+ The *surface*, or *concrete* syntax is concerned with how phrases are entered
  and displayed on a computer. It's usually thought of as given by strings of
  characters from some alphabet;
+ The *structural*, or *abstract* syntax is concerned with the structure of phrases,
  specially how they are composed from other phrases. At this level a phrase is a
  tree, called an *abstract syntax tree*, whose nodes are operators that combine
  several phrases to form another phrase;
+ The *binding* structure of syntax is concerned with the introduction and use of
  identifiers: how they are declared, and how declared identifiers can be used. At
  this level phrases are *abstract binding trees*, which enrich abstract syntax
  trees with the concepts of binding and scope.

= 1 Abstract Syntax Trees

An *abstract syntax tree* or *AST* for short, is an ordered tree whose leaves are
*variables* and whose interior nodes are *operators*, whose *arguments* are its
children
