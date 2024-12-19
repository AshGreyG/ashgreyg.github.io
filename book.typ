#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "AshGrey & Huaier's Blog",
  summary: [
    = AshGrey
    #prefix-chapter("sample-page.typ")[Hello, typst]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project
