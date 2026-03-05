#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Exc (1): Maximum Product Over Partitions Into Distinct Parts")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content, font: "C059", size: 12pt)
#show: set page(
  fill: color.background,
  numbering: "1"
)
#show link: it => {
  set text(fill: color.content-reference-link)
  it
}
#show: set math.cases(gap: 1em)
#show math.equation.where(block: true): set text(size: 14pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = Exc (1): Maximum Product Over Partitions Into Distinct Parts
])

= 1 Definitions and Preliminary Observations

Original problem is *What is the maximum possible value of the product of
positive integers whose sum is equal to $S$*. This note is concerned with a
variant of the problem that requires *all integers in the sum to be distinct*.

#definition(number: "1.1 Partition")[
  Let $n$ be a positive integer, a *partition of $n$* is a sequence
  $λ = (λ_1, ⋯, λ_k) ∈ ℕ^k$ such that $∑_i λ_i = n$ and $λ_1 ≥ ⋯ ≥ λ_k > 0$.
  Positive integers $λ_1, ⋯, λ_k$ are *parts*, and $k$ is the *length* of the
  partition.

  If all inequalities between the parts are strict, we have a partition of $n$
  into distinct parts. Hence a partition of $n$ into distinct part is a way of
  writing $n$ as a sum of distinct positive integers, disregarding the order of
  the summands. And if the order of the summands is relevant, instead of partitions
  we have *compositions*. And if we allow some summands to be zero, we get
  *week compositions*.

  More formally, a *week composition* of $n$ into $k$ parts is an ordered $k$-
  tuple $μ = (μ_1, ⋯ , μ_k)$ such that $∑_(i=1)^k μ_i = n$ and $μ_i ≥ 0$,
  $i = 1, ⋯, k$.
]

Our problem is: for a given positive integer $n$, what is the maximum value of
the product of parts over all partitions of $n$ into distinct parts.

First, a partition maximizing the product cannot contain $1$ because it follows
the relation $p ⋅ 1 < p + 1$. Another observation is $p + q < p q$ for all
$2 ≤ p < q$, implies that *a longer partition is preferred over a short one*.
Hence the product of parts will be maximized by long partitions that do not
contain $1$ as a part.

#theorem(number: "1.2")[
  Let $a$ and $l$ be positive integers greater than $1$, and let $μ$ be a weak
  partition of $l$ into $l$ parts such that all members $(a + i - 1 + μ_i)$ are
  distinct, where $1 ≤ i ≤ l$, then

  $ ∏_(i = 1)^l (a + i - 1 + μ_i) ≤ ∏_(i = 1)^l (a + i) $
]
<theorem-1-2>

#proof[
  We will show that if greatest term exceeds $a + l$, $∏_(i = 1)^l (a + i - 1 + μ_i)$
  cannot be maximal. Let us consider a product $∏_(i = 1)^l (a + i - 1 + μ_i)$
  with the greatest term $a + l + p$, where $p ≥ 1$.

  It's clear that the elements in this product cannot be consecutive. If they
  were, it would imply that all terms of the product added by at least $p + 1$, and
  the sum must increase at least $l × (p + 1)$, greater than $l$, contradiction. Hence,
  the terms in the product $∏_(i = 1)^l (a + i - 1 + μ_i)$ are not consecutive.
  Let us suppose that only one number is skipped over, we denote this number by
  $s$.

  The smallest term in this product is $a + p$. Now the list becomes to
  ${ a + p, a + p + 1, ⋯, a + p + k, a + p + k + 2, ⋯, a + p + l }$, the length
  is still $l$ but it skips over $s = a + p + k + 1$. Hence we get the sum of
  these terms:

  $ S_μ = ∑_(i = 1)^(l + 1) (a + p + i - 1) - s = (a + p)(l + 1) + l(l + 1) / 2 - s $

  On the other hand, the sum of terms in $∏_(i = 1)^l (a + i - 1)$ is given by
  $S = a l + l(l - 1) \/ 2$. But these two sum are related by $S_μ = S + l$,
  hence we get

  $ a + p(l + 1) - s = 0 $

  so $s = a + p(l + 1)$, and that's contradict when $p ≥ 2$ because it's out of
  the bound $a + i - 1 + μ_i ≤ a + 2l - 1$. For $p = 1$, we get the number
  $a + l + 1$ being skipped over, but it's also the greatest number in product
  and again contradiction. Hence there are *at least two numbers missing* in the
  sequence of terms of $∏_(i = 1)^l (a + i - 1 + μ_i)$.

  Let $a + q$ be the smallest missing number and $a + r$ be the greatest missing
  number. By replacing $(a + q - 1)(a + r + 1)$ by $(a + q)(a + r)$, we get

  $ (a + q - 1)(a + r + 1) & = a ^ 2 + (q + r - 2)a + q r + underbrace(q - r - 1, < 0) \
    & < a ^ 2 + (q + r)a + q r \
    & = (a + q)(a + r)
  $

  By this replacing we get another product of distinct terms and its value
  becomes greater than the product we started from. After repeating this procedure
  we can prove that the maximum value cannot be obtained by the product whose
  greatest term exceeds $a + l$.
]

#theorem(number: "1.3")[
  Let $n > 1$ be a positive integer and denote $T_m = binom(m + 1, 2) =
  m(m + 1) / 2$. Then there are unique positive integers $m$ and $l$ such that
  $n = T_m + l$.
]

#proof[
  We can obtain $m = floor((sqrt(8 n + 1) - 1) / 2)$ as the greatest positive
  integer so that $T_m ≤ n$. So there are a unique $l = n - binom(m + 1, 2)$.
]

= 2 Main Result

#theorem(number: "2.1")[
  Let $n ≥ 2$ be a positive integer and let $m, l ∈ ℕ$ such that $n = T_m + l$,
  where $T_m$ denotes the $m$-th triangular number, and here
  $m = floor((sqrt(8 n + 1) - 1) / 2)$. Then the maximum value $a_n$
  of the product of parts of a partition of $n$ into distinct parts is given by

  $ a_n = cases(
    (m + 1)! / (m - l)  & sans("if") 0 ≤ l ≤ m - 2,
    (m + 2) / 2 m!      & sans("if") l = m - 1,
    (m + 1)!            & sans("if") l = m
  ) $

  *Remark*: $l ≤ m$, when $l = m + 1$, $l + (m(m + 1)) / 2 = ((m + 1)(m + 2)) / 2$
]

#proof[
  + The case $l = m$ is the simplest. The longest of such an $n$ into almost
    distinct parts is given by $n = 1 + 2 + ⋯ + m + m$, according to
    #link(<theorem-1-2>)[theorem 1.2] we know the greatest product should be
    produced by #content-highlight[$(2, 3, ⋯, m, m + 1)$];
  + The case $0 ≤ l ≤ m - 2$, for partition $(1, 2, ⋯, m, l)$, the $1$ is
    unnecessary and should be added to $m$, and that produces
    $(2, ⋯, l, l, ⋯, m - 1, m + 1)$. We should distribute the repeated $l$ to
    remaining part and produce a consecutive distinct partition. We should
    distribute it to sub-partition $(m - l, m - l + 1, ⋯, m - 1)$ and produce
    a new partition $(2, ⋯, m - l - 1, m - l + 1, ⋯, m, m + 1)$, and now

    $ a_n = (m + 1)! / (m - l) $

    because $m - l$ is missing;
  + The remaining case $l = m - 1$, with the partition $(1, 2, ⋯, m - 1, m - 1, m)$.
    We will distribute $1$ and $m - 1$ to remaining part, first we distribute
    $m - 1$ to sub-partition $(2, ⋯, m - 1, m)$ to produce $(3, ⋯, m, m + 1)$,
    and finally add $1$ to $m + 1$. So the partition is $(3, ⋯, m, m + 2)$:

    $ a_n = (m + 2) / 2 m! $
]
