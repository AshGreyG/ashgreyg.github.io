#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "AshGrey & Huaier's Blog",
  summary: [
    = About
      - #chapter("./me/aboutme.typ")[About Me]

    = index
      - #chapter("./post/CS/Language/_Language.typ")[Language]
      - #chapter("./post/CS/Web3/_Web3.typ")[Web3]

    = Notes
      - #chapter(none)[Computer Science]
        - #chapter(none)[Language]
          - #chapter(none)[C++]
            - #chapter("./post/CS/Language/CPP-basic-20-coroutines.typ")[C++20 coroutines]
          - #chapter(none)[JavaScript]
            - #chapter("./post/CS/Language/JS-basic-promise.typ")[Promise in JavaScript]
          - #chapter(none)[TypeScript]
            - #chapter("./post/CS/Language/TS-basic-grammar.typ")[Basic of TypeScript]
        - #chapter(none)[Web 3]
          - #chapter(none)[Blockchain]
            - #chapter("./post/CS/Web3/Blockchain-basic-BTC.typ")[Blockchain: BTC]
      - #chapter(none)[Math]
        - #chapter(none)[Algebra]
          - #chapter(none)[Linear Algebra]
            - #chapter("./post/Math/Algebra/Linear-Algebra-basic-01-vector-spaces.typ")[Linear Algebra: 1 Vector Spaces]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project