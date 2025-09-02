#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Real Analysis (1): Number Systems")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#set page(fill: color.background)

#align(center, text(17pt)[
  = Real Analysis (1): Number Systems
])

= 1 Introduction

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
]

= 2 Ordered Sets

#definition(number: "2.1")[
  Let $S$ be a set. An *order* on $S$ is a relation, denoted by $<$, with the following
  properties:
  - If $x ∈ S$ and $y ∈ S$, then one and only one of the statements

    $ x < y, x = y, y < x $

    is true
  - If $x, y, z ∈ S$, if $x < y$ and $y < z$, then $x < z$.

  An *ordered set* is a set $S$ in which an order is defined.
]

For example, $ℕ$ and $ℚ$ are both ordered sets.

#definition(number: "2.2")[
  Suppose $S$ is an ordered set, $E ⊂ S$, and $E$ is bounded above. Suppose there
  exists an $α ∈ S$ with the following properties:

  - $α$ is an upper bound of $E$.
  - If $γ < α$ then $γ$ is not an upper bound of $E$.

  Then $α$ is called the *least upper bound* of $E$ and that there is at most one
  such $α$. It's also called the *supremum* of $E$, and we write

  $ α = "sup" E $

  The *greatest lower bound*, or *infimum*, of a set $E$ which is bounded below
  is defined in the same manner:

  $ α = "inf" E $

  means that $α$ is a lower bound of $E$ and that no $β$ with $β > α$ is a lower
  bound of $E$.
]

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
]

So the example above shows that $ℚ$ does not have the least-upper-bound property. We
shall show that every ordered set with the least-upper-bound property also has the
greatest-lower-bound property.

#theorem(number: "2.4")[
  Suppose $S$ is an ordered set with the least-upper-bound property, $B ⊂ S$, $B$ is
  not empty, and $B$ is bounded below. Let $L$ be the set of all lower bounds of $B$.
  Then
  
  $ α = "sup" L $

  exists in $S$ and $α = "inf" B$. In particular, $"inf" B$ exists in $S$.
]

#proof[
  Since $B$ is not empty and it's bounded below. $L$ consists of exactly those $y ∈ S$
  which satisfy $y ≤ x$ for every $x ∈ B$. Every $x ∈ B$ is an upper bound of $L$. Thus
  $L$ is bounded above. S is an ordered set with the least-upper-bound property, so
  according to definition 2.3, $"sup" L$ exists in $S$.

  For $γ < α$, according to definition 2.2, $γ$ is not an upper bound of $L$, hence
  $γ ∉ B$. It follows that $α ≤ x$ for every $x ∈ B$. Thus $α ∈ L$.

  If $α < β$ then $β ∉ L$, since $α$ is an upper bound of $L$.

  We have shown that $α ∈ L$ but $β ∉ L$ if $β > α$. In other words, $α$ is a lower
  bound of $B$, but $β$ is not if $β > α$. This means that $α = "inf" B$.
]

= 3 Fields

#definition(number: "3.1")[
  A field is a set $𝔽$ with two operations, called *addition* and *multiplication*,
  which satisfy the following so-called *field axioms* (A), (M) and (D): 
  
  - *(A) Axioms for addition*
    - (A1) $x ∈ 𝔽$ and $y ∈ 𝔽$, then their sum $x + y ∈ 𝔽$.
    - (A2) Addition is commutative: $x + y = y + x$ for all $x, y ∈ 𝔽$.
    - (A3) Addition is associative: $(x + y) + z = x + (y + z)$ for all $x, y, z ∈ 𝔽$.
    - (A4) $𝔽$ contains an element $0$ such that $0 + x = x$ for every $x ∈ 𝔽$.
    - (A5) To every $x ∈ 𝔽$ corresponds an element $-x ∈ 𝔽$ such that

      $ x + (-x) = 0 $

  - *(M) Axioms for multiplication*
    - (M1) If $x ∈ 𝔽$, then their product $x y$ is in $𝔽$.
    - (M2) Multiplication is commutative: $x y = y x$ for all $x, y ∈ 𝔽$.
    - (M3) Multiplication is associative: $(x y)z = x(y z)$ for all $x, y, z ∈ 𝔽$.
    - (M4) $𝔽$ contains an element $1 ≠ 0$ such that $1 x = x$ for every $x ∈ 𝔽$.
    - (M5) If $x ∈ 𝔽$ and $x ≠ 1$ then there exists an element $1 \/ x ∈ 𝔽$
      such that

      $ x⋅(1 \/ x) = 1 $

  - *(D) The distributive law*
    $ x(y + z) = x y + x z $

    holds for all $x,y,z ∈ 𝔽$.
]

The field axioms clearly hold in $ℚ$, thus $ℚ$ is a field.