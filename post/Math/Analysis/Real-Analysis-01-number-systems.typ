#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Real Analysis (1): Number Systems")
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

// This function is to solve the `highlight` function doesn't work for inline
// math mode, @see:
// 
// https://github.com/typst/typst/issues/2200
// 
// and its solution:
// 
// https://github.com/typst/typst/issues/2200#issuecomment-2669589133

#align(center, text(17pt)[
  = Real Analysis (1): Number Systems
])

= 1 Introduction <section-1-introduction>

We now show that the equation

$ p^2=2 $

is not satisfied by any rational $p$.

#proof[
  If there were such a $p$, we could write
  $p = m \/ n$ where $m$ and $n$ are integers that are not both even. Let us assume
  this is done. Then we have

  $ m^2=2n^2 $

  This shows that $m^2$ is even. Hence $m$ is even (if $m$ were odd, $m^2$ would
  be odd), and so $m^2$ is divisible by $4$. It follows that the right side is
  divisible by 4, so that $n^2$ has a factor $2$ which implies that $n$ is even.
  This leads to the conclusion that both $m$ and $n$ are even, contrary to the
  assumption. Hence it's impossible for rational $p$.
]

Let $A$ be the set of all positive rationals $p$ such that $p^2 < 2$ and let $B$
consists of all positive rationals $p$ such that $p^2 > 2$. We shall show that
*$A$ contains no largest number and $B$ contains no smallest*.

For every $p$ in $A$ we can find a rational $q$ in $A$ such that $p<q$, and for
every $p$ in $B$ we can find a rational $q$ in $B$ such that $q<p$. Let

$ q = p - (p^2 - 2) / (p+2) = (2p + 2) / (p + 2) $

Then we have

$ q^2 - 2 = (2(p^2 - 2))/(p+2)^2 $

- If $p$ is in $A$, then $p^2 - 2 < 0$, so $display(q - p = (2-p^2)/(p+2) > 0)$, 
  which implies $q > p$ and $q^2 < 2$, thus $q$ is in $A$, so $A$ contains no
  largest number.

- If $p$ is in $B$, then $p^2 - 2 > 0$, so $display(q - p = (2-p^2)/(p+2) < 0)$,
  which implies $q < p$ and $q^2 > 2$, thus $q$ is in $B$, so $B$ contains no
  smallest number.

The purpose of the above discussion has been to show that the rational number
system has certain gaps. The real number system fills these gaps.

#definition(number: "1.1")[
  If $A$ is any set whose elements may be numbers or any other objects, we write
  $x ∈ A$ to indicate that $x$ is a member or an element of $A$. If $x$ is not
  a member of $A$, we write $x ∉ A$.

  The set which contains no element will be called the *empty set*. If a set has
  at least one element, it is called *nonempty*.

  If $A$ and $B$ are sets, and if every element of $A$ is an element of $B$, we
  say that $A$ is a subset of $B$, and we write $A ⊂ B$ or $B ⊃ A$. In addition,
  if there is an element of $B$ which is not in $A$, then $A$ is said to be a
  *proper* subset of $B$.

  If $A ⊂ B$ and $B ⊂ A$, we write $A = B$. Otherwise, $A ≠ B$.
] <definition-1.1>

= 2 Ordered Sets <section-2-ordered-sets>

#definition(number: "2.1")[
  Let $S$ be a set. An *order* on $S$ is a relation, denoted by $<$, with the following
  properties:
  - If $x ∈ S$ and $y ∈ S$, then one and only one of the statements

    $ x < y, x = y, y < x $

    is true <order-property-1>
  - If $x, y, z ∈ S$, if $x < y$ and $y < z$, then $x < z$. <order-property-2>

  An *ordered set* is a set $S$ in which an order is defined.
] <definition-2.1>

For example, $ℕ$ and $ℚ$ are both ordered sets.

#definition(number: "2.2")[
  Suppose $S$ is an ordered set, $E ⊂ S$, and $E$ is bounded above. Suppose there
  exists an $α ∈ S$ with the following properties:

  - $α$ is an upper bound of $E$. <ordered-set-property-1>
  - If $γ < α$ then $γ$ is not an upper bound of $E$. <ordered-set-property-2>

  Then $α$ is called the *least upper bound* of $E$ and that there is at most one
  such $α$. It's also called the *supremum* of $E$, and we write

  $ α = "sup" E $

  The *greatest lower bound*, or *infimum*, of a set $E$ which is bounded below
  is defined in the same manner:

  $ α = "inf" E $

  means that $α$ is a lower bound of $E$ and that no $β$ with $β > α$ is a lower
  bound of $E$.
] <definition-2.2>

+ Consider the sets $A$ and $B$ of example in introduction as subsets of the ordered
  set $ℚ$. The set $A$ is bounded above. In fact the upper bounds of $A$ are exactly
  the members of $B$. Since $B$ contains no smallest member, $A$ *has no least upper
  bound in $ℚ$*. Similarly, $B$ is bounded below: the set of all lower bounds of $B$
  consists of $A$ and of all $r ∈ ℚ$ with $r ≤ 0$. Since $B$ contains no smallest
  member, $B$ *has no greatest lower bound in $ℚ$*.

+ If $α = "sup" E$ exists, then $α$ may or may not be member of $E$. For instance,
  let $E_1$ be the set of all $r ∈ ℚ$ with $r < 0$. Let $E_2$ be the set of all
  $r ∈ ℚ$ with $r ≤ 0$. Then

  $ "sup" E_1 = "sup" E_2 = 0 $

  and $0 ∉ E_1, 0 ∈ E_2$.


#definition(number: "2.3")[
  An ordered set $S$ is said to have the *least-upper-bound property* if the following
  is true: If $E ⊂ S$ is not empty, and $E$ is bounded above, then $"sup" E$ exists in $S$.
] <definition-2.3>

So the example above shows that $ℚ$ does not have the least-upper-bound property. We
shall show that every ordered set with the least-upper-bound property also has the
greatest-lower-bound property.

#theorem(number: "2.4")[
  Suppose $S$ is an ordered set with the least-upper-bound property, $B ⊂ S$, $B$ is
  not empty, and $B$ is bounded below. Let $L$ be the set of all lower bounds of $B$.
  Then
  
  $ α = "sup" L $

  exists in $S$ and $α = "inf" B$. In particular, $"inf" B$ exists in $S$.
] <theorem-2.4>

#proof[
  Since $B$ is not empty and it's bounded below. $L$ consists of exactly those $y ∈ S$
  which satisfy $y ≤ x$ for every $x ∈ B$. Every $x ∈ B$ is an upper bound of $L$. Thus
  $L$ is bounded above. S is an ordered set with the least-upper-bound property, so
  according to #link(<definition-2.3>)[definition 2.3], $"sup" L$ exists in $S$.

  For $γ < α$, according to #link(<definition-2.2>)[definition 2.2], $γ$ is not
  an upper bound of $L$, hence $γ ∉ B$. It follows that $α ≤ x$ for every $x ∈ B$.
  Thus $α ∈ L$.

  If $α < β$ then $β ∉ L$, since $α$ is an upper bound of $L$.

  We have shown that $α ∈ L$ but $β ∉ L$ if $β > α$. In other words, $α$ is a lower
  bound of $B$, but $β$ is not if $β > α$. This means that $α = "inf" B$.
]

= 3 Fields

#definition(number: "3.1")[
  A field is a set $𝔽$ with two operations, called *addition* and *multiplication*,
  which satisfy the following so-called *field axioms* (A), (M) and (D): 
  
  - *(A) Axioms for addition* <axiom-addition>
    - (A1) $x ∈ 𝔽$ and $y ∈ 𝔽$, then their sum $x + y ∈ 𝔽$.
      <axiom-addition-a1>
    - (A2) Addition is commutative: $x + y = y + x$ for all $x, y ∈ 𝔽$.
      <axiom-addition-a2>
    - (A3) Addition is associative: $(x + y) + z = x + (y + z)$ for all $x, y, z ∈ 𝔽$.
      <axiom-addition-a3>
    - (A4) $𝔽$ contains an element $0$ such that $0 + x = x$ for every $x ∈ 𝔽$.
      <axiom-addition-a4>
    - (A5) To every $x ∈ 𝔽$ corresponds an element $-x ∈ 𝔽$ such that

      $ x + (-x) = 0 $
      <axiom-addition-a5>

  - *(M) Axioms for multiplication* <axiom-multiplication>
    - (M1) If $x ∈ 𝔽$, then their product $x y$ is in $𝔽$.
      <axiom-multiplication-m1>
    - (M2) Multiplication is commutative: $x y = y x$ for all $x, y ∈ 𝔽$.
      <axiom-multiplication-m2>
    - (M3) Multiplication is associative: $(x y)z = x(y z)$ for all $x, y, z ∈ 𝔽$.
      <axiom-multiplication-m3>
    - (M4) $𝔽$ contains an element $1 ≠ 0$ such that $1 x = x$ for every $x ∈ 𝔽$.
      <axiom-multiplication-m4>
    - (M5) If $x ∈ 𝔽$ and $x ≠ 1$ then there exists an element $1 \/ x ∈ 𝔽$
      such that

      $ x⋅(1 \/ x) = 1 $
      <axiom-multiplication-m5>

  - *(D) The distributive law* <axiom-distributive>
    $ x(y + z) = x y + x z $

    holds for all $x,y,z ∈ 𝔽$.
] <definition-3.1>

The field axioms clearly hold in $ℚ$, thus $ℚ$ is a field. There are many useful
propositions of a field. Here is a proposition I'm interested: if $x ≠ 0$ and
$y ≠ 0$, then $x y ≠ 0$.

#proof[
  First let we prove two propositions:

  + *If $x + y = x$ then $y = 0$*. Proof: $y = 0 + y = (-x + x) + y = -x + (x + y) = -x + x = 0$.
  + *$0x=0$*. Proof: $0x + 0x = (0 + 0)x = 0x$, according to the proposition above, $0x = 0$.

  Assume that $x ≠ 0$, $y ≠ 0$ but $x y = 0$, then

  $ 1 = (1 / y)(1 / x)x y=(1 / y)(1 / x)0 = (1 / y)0 = 0 $

  and that's a contradiction, thus the proposition holds.
]

#definition(number: "3.2")[
  An *ordered filed* is a field $𝔽$ which is also an ordered set, such that

  + $x + y < x + z$ if $x,y,z ∈ 𝔽$ and $y < z$.
  + $x y > 0$ if $x ∈ 𝔽$, $y ∈ 𝔽$, $x > 0$ and $y > 0$.

  If $x > 0$, we call $x$ *positive*; if $x < 0$, $x$ is *negative*.
] <definition-3.2>

= 4 The Real Field

#theorem(number: "4.1")[
  There exists an ordered field $ℝ$ which has the least-upper-bound property. Moreover,
  $ℝ$ contains $ℚ$ as a subfield.

  The second statement means that $ℚ ⊂ ℝ$ and that the operations of addition and
  multiplication in $ℝ$, when applied to members of $ℚ$, coincide with the usual operations
  on rational numbers; also, the positive rational numbers are positive elements of
  $ℝ$. The members of $ℝ$ are called *real numbers*.
] <theorem-4.1>

#proof[
  + *Step 1* The members of $ℝ$ will be certain subsets of $ℚ$, called *cuts*. By definition,
    a cut is any set $α ⊆ ℚ$ with the following properties:

    + $α$ is not empty, and $α ≠ ℚ$. <cut-property-1>
    + If $p ∈ α, q ∈ ℚ$, and $q < p$, then $q ∈ α$. <cut-property-2>
    + If $p ∈ α$, then $p < r$ for some $r ∈ α$. <cut-property-3>

    Notice that 3 simply says that $α$ has no largest member, 2 implies two facts which will
    be used freely:

    - If $p ∈ α$ and $q ∉ α$, then $p < q$. <cut-fact-1>
    - If $r ∉ α$ and $r < s$, then $s ∉ α$. <cut-fact-2>

    *Notice cut $α$ divides the $ℚ$ into two parts: the left part is $α$, the right
    part is $ℚ\\α$.*

  + *Step 2* Define $α < β$ to mean: $α$ is a proper subset of $β$.

    If $α < β$ and $β < γ$ it is clear that $α < γ$. (A proper subset of a proper subset is
    a proper subset). And it's also clear that at most one of the three relations $α < β$,
    $α = β$ and $α > β$ can hold for any pair $α, β$. To show that at least one holds, assume
    that the first two fail. Then $α$ is not a subset of $β$. Hence there is a $p ∈ α$ with
    $p ∉ β$. If $q ∈ β$, it shows that $q < p$ since $p ∉ β$, hence $q ∈ α$ (according to
    the property 2 of cut). Thus $β ⊂ α$, when $α ≠ β$ we have $β < α$.

    Thus $ℝ$ is now an ordered set.

  + *Step 3* Now we prove *the ordered set $ℝ$ has the least-upper-bound property*.

    To prove this, let $A$ be a nonempty subset of $ℝ$, and assume that $β ∈ ℝ$ is an upper
    bound of $A$ (*Notice $ℝ$ and its nonempty subset $A$ are all the sets of cuts*). Define
    $γ$ to be the union of all $α ∈ A$. We shall prove that $γ ∈ ℝ$ (that is to say, $γ$
    is a cut) and that $γ = "sup" A$.

    $ ⋃_(α ∈ A \ A ⊂ ℝ, A ≠ ∅) α = "sup" A $

    + Since $A$ is not empty, there exists $α_0 ∈ A$. This $α_0$ is not empty. Since $α_0 ⊂ γ$,
      #content-highlight[$γ$ is not empty]. Next, $γ ⊂ β$ since $α < β$ for every $α ∈ A$ because $β$
      is the upper bound of $A$. #content-highlight[So $γ ≠ ℚ$]. Thus $γ$ satisfies
      #link(<cut-property-1>)[property 1 of cut].

      // There is a problem with normal form reference, text cannot be referenced @see:
      // 
      // https://typst.app/docs/reference/model/ref/
      //
      // and its solution is to use #link rather than #ref

    + Pick $p ∈ γ$, then $p ∈ α_1$ for some $α_1 ∈ A$. #content-highlight[If $q < p$, 
      then $q ∈ α_1$, hence $q ∈ γ$]. This proves the #link(<cut-property-2>)[property 2].

    + If $r ∈ α_1$ is so chosen that $r > p$, we see that $r ∈ γ$ since $α_1 ⊂ γ$ and therefore
      $γ$ satisfies #link(<cut-property-3>)[property 3].

    Thus $γ$ is a cut and $γ ∈ ℝ$. It's clear that $α ≤ γ$ for every $α ∈ A$. Suppose
    $δ < γ$. Then there is an $s ∈ γ$ such that $s ∉ δ$. Since $s ∈ γ$, so $s ∈ α_2$ for
    some $α_2 ∈ A$. Hence $δ < α_2$ and $δ$ is not an upper bound of $A$.

    So $γ = "sup" A$.

  + *Step 4* If $α ∈ ℝ$ and $β ∈ ℝ$, we define $α + β$ to be the set of all sums $r + s$,
    where $r ∈ α$ and $s ∈ β$.

    We define $0^*$ to be the set of all negative rational numbers, we know $0^*$ is a
    cut of $ℚ$. We verify that *the axioms for addition* hold in $ℝ$, with $0^*$ playing
    the role of $ℚ$.

    - (A1) We have to show that $α + β$ is a cut. Because $ℚ$ is a ordered field, so
      for every $r ∈ α$ and $s ∈ β$, $r + s ∈ ℚ$, that's to say $α + β ⊆ ℚ$ and it's not
      empty. Take $r' ∉ α$ and $s' ∉ β$. Then $r' + s' > r + s$ for all choices of
      $r ∈ α$ and $s ∈ β$. Thus $r' + s' ≠ α + β$. So $α + β ≠ ℚ$. It follows that
      #content-highlight[$α + β$ has property 1 of cut].

      Pick $p ∈ α + β$. Then exists $r ∈ α, s ∈ β$, $r + s = p$. If $q < p$, then
      $q - s < r$, so $q - s ∈ α$, thus $q = (r - s) + s ∈ α + β$. #content-highlight[Thus
      $$]

]