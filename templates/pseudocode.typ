#import "@preview/lovelace:0.3.0": pseudocode-list

#let pseudocode(title, content) = stack(
  spacing: 6pt,
  line(length: 100%, stroke: 1pt),
  [*#title*],
  line(length: 100%, stroke: .5pt),
  pseudocode-list(hooks: .3em)[#content],
  line(length: 100%, stroke: 1pt),
)
