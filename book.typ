#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "AshGrey & Huaier's Blog",
  summary: [
    = About
      - #chapter("./me/aboutme.typ")[About Me]

    = index
      - #chapter("./post/CS/Language/_Language.typ")[Language]

    = Notes
      - #chapter(none)[Computer Science]
        - #chapter(none)[Language]
          - #chapter(none)[C++]
            - #chapter("./post/CS/Language/CPP-basic-20-coroutines.typ")[C++20 coroutines]
          - #chapter(none)[JavaScript]
            - #chapter("./post/CS/Language/JS-basic-promise.typ")[Promise in JavaScript]
          - #chapter(none)[TypeScript]
            - #chapter("./post/CS/Language/TS-basic-grammar.typ")[Basic of TypeScript]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project