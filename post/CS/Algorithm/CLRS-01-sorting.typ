#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "@preview/shiroa:0.2.3": *
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (1): Sorting")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#show: set page(
  fill: color.background,
  numbering: "1"
)
#show link: it => {
  set text(fill: color.content-reference-link)
  it
}

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

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

== 1.1 Bubble Sort

Bubble sort is a simple sorting algorithm that repeatedly steps through the
input list element by element, comparing the current element with the one after
it, swapping their values if needed.

These passes through the list are repeated until no swaps have to be performed
during a pass, meaning that the list has become full sorted.

#pseudocode(
  [Algorithm 1.1: Bubble Sort],
  [
    + *procedure* #smallcaps("Bubble-Sort") (A)
      + ▷ A is an array, in the following code, $upright("A")[i]$ represents the
        key of element.
      + $n$ ← $sans("length")(upright("A"))$
      + swapped ← $sans("true")$
      + *while* swapped $sans("is true")$ *do*
        + swapped ← $sans("false")$
        + *for* $i$ *in* $sans("range")(1..n-1, "step": 1)$ *do*
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

#theorem(number: "1.1 Average-Case Complexity of Bubble Sort")[
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
  [Algorithm 1.2: Memorized Bubble Sort],
  [
    + *procedure* #smallcaps("Memorized-Bubble-Sort") (A)
      + ▷ A is an array, in the following code, $upright("A")[i]$ represents the
        key of element.
      + $n$ ← $sans("length")(upright("A"))$
      + $j$ ← $sans("length")(upright("A"))$
      + swapped ← $sans("true")$
      + *while* swapped $sans("is true")$ *do*
        + swapped ← $sans("false")$
        + *for* $i$ *in* $sans("range")(1..j-1, "step": 1)$ *do*
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
      and its memorized version (max and average have \
      been pre-scaled down by 150)]
  ),
  figure(
    image("Bubble-Sort-Benchmark-Memory.svg", width: 50%),
    caption: [Execution memory benchmark of bubble sort \
      and its memorized version]
  ),
)

Actually the space complexity of bubble sort is $O(1)$. The sharp spike in this
chart is due to malloc function of Python.

== 1.2 Insertion Sort

Insertion Sort is a simple sorting algorithm that builds the final sorted array
one item at a time by comparisons. Insertion sort iterates, consuming one input
element each repetition, and grows a sorted output list. At each iteration, and
grows a sorted output list.

At each iteration, insertion sort removes one element from the input data, finds
the correct location within the sorted list, and inserts it here. It repeats until
no input elements remain.

#pseudocode(
  [Algorithm 1.3: Insertion Sort],
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

In the worst case, for every loop from index $i$ to $0$, insertion sort needs 
$i$ swap hence the worst time complexity is $n(n + 1) \/ 2 ~ O(n^2)$. Here is
the benchmark of insertion sort:

#stack(
  dir: ltr,
  figure(
    image("Insertion-Sort-Benchmark-Time.svg", width: 50%),
    caption: [Execution time benchmark of insertion \
      sort (max and average have been pre-scaled down \
      by 50)]
  ),
  figure(
    image("Insertion-Sort-Benchmark-Memory.svg", width: 50%),
    caption: [Execution memory benchmark of insertion sort]
  ),
)

The average-case complexity of insertion sort is $Θ(n^2)$. According to the
analysis of bubble sort, any sort based on swapping the reverse pair one by one
has average-case complexity $Θ(n^2)$.

== 1.3 Merge Sort

The *merge sort* algorithm closely follows the
#cross-link("/post/CS/Algorithm/CLRS-00-foundations.typ")[divide and conquer]
paradigm which involves tree steps at each level of recursion:

+ *Divide*: Divide the $n$-element sequence to be sorted into two subsequences
  of $n / 2$ elements each;
+ *Conquer*: Sort the two subsequences recursively using merge sort;
+ *Combine*: Merger the two sorted subsequences to produce the sorted answer.

The recursion bottoms out when the sequence to be sorted has length $1$, in which
case there is no work to be done. Since every sequence of length $1$ is already
in sorted order.

#pseudocode(
  [Algorithm 1.4 Merge Sort],
  [
    + *procedure* #smallcaps("Merge-Sort") (A, $p$, $r$)
    + *function* Merge($upright("A"), p, q, r$)
      + $n_1$ ← $q - p + 1$
      + $n_2$ ← $r - q$
      + let $upright("L")[0..n_1]$ and $upright("R")[0..n_2]$ be new arrays
      + *for* $i$ *in* $sans("range")(0..n_1 - 1)$ *do*
        + $upright("L")[i]$ ← $upright("A")[p + i - 1]$
      + *for* $j$ *in* $sans("range")(0..n_2 - 1)$ *do*
        + $upright("R")[j]$ ← $upright("A")[q + j]$
      + $upright("L")[n_1]$ ← $∞$
      + $upright("R")[n_2]$ ← $∞$
      + $i$ ← $0$
      + $j$ ← $0$
      + *for* $k$ *in* $sans("range")(p..r)$ *do*
        + *if* $upright("L")[i] ≤ upright("R")[j]$ *then*
          + 
  ]
)


= 2 Non-Comparison Sort

== 2.1 Bucket Sort

Bucket sort assumes that the input is drawn from a uniform distribution and has
an average-case running time of $Θ(n)$. Bucket sort divides the interval
$[0, 1)$ into $n$ equal-sized subintervals or called *buckets*, and then
distributes the $n$ input numbers into the buckets.

#pseudocode(
  [Algorithm 2.1: Bucket Sort],
  [
    + *procedure* #smallcaps("Bucket-Sort") (A)
    + $n$ ← $sans("length")(upright("A"))$
    + let $upright("B")[0..n - 1]$ be a new array
    + *for* $i$ in $sans("range")(0..n - 1)$ *do*
      + ▷ Notice when parameter `step` is skipped, then it's default value `1`
      + make $upright("B")[i]$ an empty linked list
    + *for* $i$ in $sans("range")(0..n - 1)$ *do*
      + insert $upright("A")[i]$ into list $upright("B")[floor(n upright("A")[i])]$
    + *for* $i$ in $sans("range")(0..n - 1)$ *do*
      + sort list $upright("B")[i]$ with insertion sort
    + concatenate the lists $upright("B")[0],upright("B")[1],⋯,upright("B")[n - 1]$
      together in order.
  ]
)

Assume that $upright("A")[i] ≤ upright("A")[j]$, so $floor(n A[i]) ≤ floor(n A[j])$
either element $A[i]$ goes into the same buckets as $A[j]$ or it goes into a
bucket with a lower index. And if they goes into same bucket the ordering step
will put them in proper order.

Let $n_i$ be the random variable denoting the number of elements placed in
bucket $upright("B")[i]$. Since insertion sort runs in $O(n^2)$ time the running
time of bucket sort is

$ T(n) = Θ(n) + ∑_(i = 0)^(n - 1) O(n_i^2) $

We take the expectation over the input distribution of both sides and using
linearity of expectation we have

$ 𝔼[T(n)] & = 𝔼[Θ(n) + ∑_(i = 0)^(n - 1) O(n_i^2) ] \
  & = Θ(n) + ∑_(i = 0)^(n - 1) 𝔼[O(n_i^2)] space.en ("by linearity of expectation") \
  & = Θ(n) + ∑_(i = 0)^(n - 1) O(𝔼[n_i^2]) space.en ("by" 𝔼(a X) = a 𝔼(X))
$

Each bucket $i$ has the same value of $𝔼[n_i^2]$ for $i = 0,1,⋯,n - 1$, since
each value in the input array $A$ is equally likely to fall in any bucket. We
define indicator random variables $X_(i j) = 1$ when $upright("A")[j]$ falls
in bucket $i$ for $i = 0,1,⋯,n - 1$ and $j = 0,1,⋯,n - 1$. Thus
$n_i = ∑_(j = 0)^(n - 1) X_(i j)$. To compute $𝔼[n_i^2]$ we expand the square
and regroup items:

$ 𝔼[n_i^2] & = 𝔼[(∑_(j = 0)^(n - 1) X_(i j))] ^ 2 \
  & = 𝔼[∑_(j = 0)^(n - 1) ∑_(k = 0)^(n - 1) X_(i j) X_(i k)] \
  & = 𝔼[∑_(j = 0)^(n - 1) X_(i j)^2 + ∑_(0 ≤ j ≤ n - 1) ∑_(0 ≤ k ≤ n - 1 \ k ≠ j)
    X_(i j) X_(i k)] \
  & = ∑_(j = 0)^(n - 1) 𝔼[X_(i j)^2] + ∑_(0 ≤ j ≤ n - 1) ∑_(0 ≤ k ≤ n - 1 \ k ≠ j)
    𝔼[X_(i j) X_(i k)]
$

Where the last line follows by linearity of expectation. And we can evaluate
the two summations separately. Indicator random variable $X_(i j)$ is $1$ with
probability $1 / n$ and $0$ otherwise, therefore

$ 𝔼[X_(i j)^2] = 1^2 ⋅ 1 / n + 0^2 ⋅ (1 - 1 / n) = 1 / n $

When $k ≠ j$, the variables $X_(i j)$ and $X_(i k)$ are independent and hence

$ 𝔼[X_(i j) X_(i k)] = 𝔼[X_(i j)]𝔼[X_(i k)] = 1 / n ⋅ 1 / n = 1 / n^2 $

so we have

$ 𝔼[n_i^2] & = ∑_(j = 0)^(n - 1) 1 / n + ∑_(0 ≤ j ≤ n - 1) 
    ∑_(0 ≤ k ≤ n - 1 \ k ≠ j) 1 / n^2 \
  & = n ⋅ 1 / n + n(n - 1) 1 / n^2 \
  & = 2 - 1 / n
$

So substitute the $𝔼[n_i^2]$ in expression of $𝔼[T(n)]$ we have:

$ 𝔼[T(n)] = Θ(n) + ∑_(i = 0)^(n - 1) O(𝔼[n_i^2]) = Θ(n) + n(2 - 1 / n) 
  = Θ(n) + 2n - 1 $

We can implement a benchmark for bucket sort:

#stack(
  dir: ltr,
  figure(
    image("Bucket-Sort-Benchmark-Time.svg", width: 50%),
    caption: [Execution time benchmark of bucket \
      sort (max and average have been pre-scaled down \
      by 10)]
  ),
  figure(
    image("Bucket-Sort-Benchmark-Memory.svg", width: 50%),
    caption: [Execution memory benchmark of bucket sort]
  ),
)


