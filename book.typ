#import "@preview/shiroa:0.2.3": *

#show: book

#book-meta(
  title: "Saved notes of AshGrey 🐿️",
  summary: [
    = Notes
      - #chapter(none)[Computer Science]
        - #chapter(none)[Computer Organization]
          - #chapter(none)[DDCA]
            - #chapter("./post/CS/CO/DDCA-01-fundamentals.typ")[DDCA (1): Fundamentals]
        - #chapter(none)[Algorithm]
          - #chapter(none)[CLRS]
            - #chapter("./post/CS/Algorithm/CLRS-00-foundations.typ")[CLRS (0): Foundations]
            - #chapter("./post/CS/Algorithm/CLRS-01-sorting.typ")[CLRS (1): Sorting]
            - #chapter("./post/CS/Algorithm/CLRS-02-data-structure.typ")[CLRS (2): Data Structure]
          - #chapter(none)[Exercise Notes]
            - #chapter("./post/CS/Algorithm/Exc-01-maximum-product-product.typ")[Exc (1): Maximum Product Over Partitions Into Distinct Parts]
        - #chapter(none)[Cryptography]
          - #chapter(none)[Basic]
            - #chapter("./post/CS/Cryptography/Cryptography-basic-01-introduction.typ")[Modern Cryptography (1): Introduction]
      - #chapter(none)[Math]
        - #chapter(none)[Algebra]
          - #chapter(none)[Linear Algebra]
            - #chapter("./post/Math/Algebra/Linear-Algebra-basic-01-vector-spaces.typ")[Linear Algebra (1): Vector Spaces]
          - #chapter(none)[Abstract Algebra]
            - #chapter("./post/Math/Algebra/Abstract-Algebra-basic-01-categories-theory.typ")[Abstract Algebra (1): Categories Theory]
        - #chapter(none)[Analysis]
          - #chapter(none)[Real Analysis]
            - #chapter("./post/Math/Analysis/Real-Analysis-01-number-systems.typ")[Real Analysis (1): Number System]
        - #chapter(none)[Number Theory]
          - #chapter(none)[Elementary Number Theory]
            - #chapter("./post/Math/Number-Theory/Elementary-basic-01-integers.typ")[Elementary Number Theory (1): Integers]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project
