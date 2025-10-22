#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (1): Sorting")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#show: set page(fill: color.background)

#align(center, text(17pt)[
  = CLRS (1): Sorting
])

Sorting problem is

#list(
  [*Input*: A sequence of $n$ numbers $⟨a_1,a_2,⋯,a_n⟩$],
  [*Output*: A permutation (recording) $⟨a_1^',a_2^',⋯,a_n^'⟩$ of the input
    sequence such that $a_1^'≤a_2^'≤⋯≤a_n^'$],
)

The data to be sorted is usually each a collection of data called a *record*,
each record contains a *key*, which is the value to be sorted. The remainder
of the record consists of *satellite data*, which are usually carried around
with the key.

If each record includes a large amount of satellite data, we often permute an
array of pointers to the records rather than the records themselves in order to
minimize data movement.

= 1 Comparison Sort

= 1.1 Bubble Sort

Bubble sort is a simple sorting algorithm that repeatedly steps through the
input list element by element, comparing the current element with the one after
it, swapping their values if needed.

These passes through the list are repeated until no swaps have to be performed
during a pass, meaning that the list has become full sorted.

#pseudocode(
  [Algorithm 1: Bubble Sort],
  [
    + *procedure* #smallcaps("Bubble-Sort") (A)
      + ▷ A is an array, in the following code, $upright("A")[i]$ represents the
        key of element.
      + $n$ ← $sans("length")(upright("A"))$
      + swapped ← $sans("true")$
      + *while* swapped $sans("is true")$ *do*
        + swapped ← $sans("false")$
        + *for* i *in* $sans("range")(1..n-1, "step": 1)$ *do*
          + *if* $upright("A")[i] > upright("A")[i-1]$ *then*
            + $sans("swap")(upright("A")[i-1], upright("A")[i])$
            + swapped ← $sans("true")$
            + ▷ When there is no swap, the array has been sorted.
  ]
)

In the worst case, the input array is totally ordered in reverse, outer loop 
executes $n$ times and inner loop executes also $n$ times, so the *worst-case 
time complexity* is $O(n^2)$.

In the best case, the input array is ordered, algorithm only needs to scan the
whole array and doesn't need swapping. So the *best-case time complexity* is
$Ω(n)$.

#theorem(number: "1.1 Average-Case Complexity")[
  The average-case complexity of bubble sort is $Θ(n^2)$
]

#proof[
  If $0 ≤ i < j < n$ and $upright("A")[i] > upright("A")[j]$, we call pair $(i,j)$ an
  inversion. For any two indexes $(i,j)$ here $i<j$, there is a $display(1/2)$
  probability that $upright("A")[i]>upright("A")[j]$. Because there are 
  $display(mat(n;2)=n(n-1)/2)$ inversions, so the expectation of number of inversion is

  $ EE(i)=1/2 × n(n-1)/2 = n(n-1)/4 $

  Comparison still needs $display(n(n-1)/2)$ steps, A swapping step is to
  eliminate an inversion, so swapping needs $display(n(n-1)/4)$ steps.

  The average-case complexity is $Θ(n^2)$.
]

We can use memorization to shorten the execution time:

#pseudocode(
  [Algorithm 2: Memorized Bubble Sort],
  [
    + *procedure* #smallcaps("Memorized-Bubble-Sort") (A)
      + ▷ A is an array, in the following code, $upright("A")[i]$ represents the
        key of element.
      + $n$ ← $sans("length")(upright("A"))$
      + $j$ ← $sans("length")(upright("A"))$
      + swapped ← $sans("true")$
      + *while* swapped $sans("is true")$ *do*
        + swapped ← $sans("false")$
        + *for* i *in* $sans("range")(1..j-1, "step": 1)$ *do*
          + *if* $upright("A")[i] > upright("A")[i-1]$ *then*
            + $sans("swap")(upright("A")[i-1], upright("A")[i])$
            + swapped ← $sans("true")$
            + j ← i
            + ▷ Bubble sort will move the largest element to the tail, the sub-array
             after last swapping index has been sorted.
            + ▷ When there is no swap, the array has been sorted.
  ]
)

Here is the benchmark of bubble sort and memorized bubble sort:

#stack(
  dir: ltr,
  figure(
    image("Bubble-Sort-Benchmark-Time.svg", width: 50%),
    caption: [Execution time benchmark of bubble sort \
      and its memorized version]
  ),
  figure(
    image("Bubble-Sort-Benchmark-Memory.svg", width: 50%),
    caption: [Execution memory benchmark of bubble sort \
      and its memorized version]
  ),
)

The peaks of execution memory chart are not the real peak of execution, actually
the space complexity of bubble sort is $O(1)$.

= 1.2 Insertion Sort

Insertion Sort is a simple sorting algorithm that builds the final sorted array
one item at a time by comparisons. Insertion sort iterates, consuming one input
element each repetition, and grows a sorted output list. At each iteration, and
grows a sorted output list.

At each iteration, insertion sort removes one element from the input data, finds
the correct location within the sorted list, and inserts it here. It repeats until
no input elements remain.

#pseudocode(
  [Algorithm 3: Insertion Sort],
  [
    + *procedure* #smallcaps("Insertion-Sort") (A)
    + ▷ A is an array, in the following code, $upright("A")[i]$ represents the
        key of element.
    + $i$ ← 1
    + *while* $i < sans("length")(upright("A"))$ *do*
      + $j$ ← $i$
      + *while* $j > 0 sans("and") upright("A")[j-1] > upright("A")[j]$
        + $sans("swap")(upright("A")[i], upright("A")[i-1])$
        + ▷ When $upright("A")[j-1] ≤ upright("A")[j]$, the insertion position has been found.
        + $j$ ← $j-1$
      + $i$ ← $i+1$
  ]
)

In the worst case, 
