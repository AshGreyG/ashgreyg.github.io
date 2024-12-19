#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "AshGrey & Huaier's Blog",
  summary: [
    = About
      - #chapter("./me/aboutme.typ")[About Me]
    = Notes
      - #chapter(none)[Computer Science]
        - #chapter(none)[Language]
          - #chapter("./post/CS/Language/CPP.typ")[C++]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project
