#import "@preview/shiroa:0.2.0": *

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
        - #chapter(none)[Algorithm]
          - #chapter(none)[CLRS]
            - #chapter("./post/CS/Algorithm/CLRS-01-sorting.typ")[CLRS (1): Sorting]
            - #chapter("./post/CS/Algorithm/CLRS-02-data-structure.typ")[CLRS (2): Data Structure]
        - #chapter(none)[Language]
        - #chapter(none)[Cryptography]
          - #chapter(none)[Basic]
            - #chapter("./post/CS/Cryptography/Cryptography-basic-01-introduction.typ")[Modern Cryptography (1): Introduction]
        - #chapter(none)[Web 3]
          - #chapter(none)[Blockchain]
            - #chapter("./post/CS/Web3/Blockchain-basic-BTC.typ")[Blockchain: BTC]
      - #chapter(none)[Math]
        - #chapter(none)[Algebra]
          - #chapter(none)[Linear Algebra]
            - #chapter("./post/Math/Algebra/Linear-Algebra-basic-01-vector-spaces.typ")[Linear Algebra (1): Vector Spaces]
          - #chapter(none)[Abstract Algebra]
            - #chapter("./post/Math/Algebra/Abstract-Algebra-basic-01-categories-theory.typ")[Abstract Algebra (1): Categories Theory]
        - #chapter(none)[Number Theory]
          - #chapter(none)[Elementary Number Theory]
            - #chapter("./post/Math/Number-Theory/Elementary-basic-01-integers.typ")[Elementary Number Theory (1): Integers]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project