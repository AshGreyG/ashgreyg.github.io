#import "@preview/lovelace:0.3.0": pseudocode-list
#import "/templates/color.typ" as color

#let pseudocode(title, content) = {
  set text(fill: color.content)
  stack(
    spacing: 6pt,
    line(length: 100%, stroke: 1pt + color.content),
    [*#title*],
    line(length: 100%, stroke: .5pt + color.content),
    pseudocode-list(hooks: .3em)[#content],
    line(length: 100%, stroke: 1pt + color.content),
  )
}
