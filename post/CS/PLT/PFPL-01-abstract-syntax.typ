#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#import "/templates/theorem.typ": *

#show: book-page.with(title: "Linear Algebra (1): Vector Spaces")

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