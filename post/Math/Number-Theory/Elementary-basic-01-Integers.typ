#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Elementary Number Theory (1): Integers")

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", fill: rgb("#e8e8f8"))

#let proof = thmproof("proof", "Proof")

#align(center, text(17pt)[
  = Elementary Number Theory (1): Integers
])

= 1 Number and Sequences

= 1.1 Numbers

The integers are the numbers in the set ${...,-3,-2,-1,0,1,2,3,...}$. Every nonempty set of positive integers has a least element. That is called *well-ordering* property (notice this is an axiom of set theory), we say that the set of positive integers is *well ordered*. However the set of all integers is not well ordered, as there are sets of integers without a smallest element.

Another important class of numbers in the number theory is the set of numbers that can be written as *ratios* of integers.

#definition(number: "1.1 rational")[
  The real number $r$ is *rational* if there are integers $p$ and $q$ such that $r=p\/q$. If $r$ is not rational, it is *irrational*.
]

Note that every integer $n$ is a rational number because $n=n\/1$.

#theorem(number: "1.1")[
  $sqrt(2)$ is irrational.
]

#proof[
  Suppose that $sqrt(2)$ were rational. Then there would exist positive integers $a$ and $b$ such that $sqrt(2)=a\/b$. Consequently, the set $S={k sqrt(2) | k in ZZ^+ and k sqrt(2) in ZZ^+}$ is a nonempty set of positive integers. Therefore, by the well-ordering property, $S$ has a smallest element, we can denote it as $s=t sqrt(2)$. Here $s$ and $t$ are both integers.
  
  We have $s sqrt(2)-s=s sqrt(2)-t sqrt(2)=(s-t)sqrt(2)$. Because $s sqrt(2)=2t$ and $s$ are both integers, $s sqrt(2) -s=(s-t)sqrt(2)$ must also be an integer. Furthermore, $s sqrt(2)-s=s(sqrt(2)-1)$ is also positive, and it's less than $s$, because $sqrt(2) < 2$. This contradicts the choice of $s$ as the smallest positive integer in $S$. So it follows that $sqrt(2)$ is irrational.
]

#definition(number: "1.2 algebraic")[
  A number $alpha$  is *algebraic* if it is the root of a polynomial with integer coefficients. That is, $alpha$ is algebraic if there exist integers $a_0,...,a_n$ such that

  $ a_n alpha^n+a_(n-1) alpha^(n-1)+dots.c+a_0=0 $

  The number $alpha$ is called *transcendental* if it is not algebraic.
]

Note that every rational number is algebraic. This follow from the fact that the number $a\/b$, where $a$ and $b$ are integers and $b!=0$, is the root of $b x-a=0$.

= 1.2 The Greatest Integer Function

#definition(number: "1.3 greatest integer")[
  The *greatest integer* of a real number $x$, denoted by $[x]$, is the largest integer less than or equal to $x$. That is, $[x]$ is the integer satisfying

  $ [x]<=x<[x]+1 $
]

The greatest integer function is also known as the *floor function*, computer scientists usually use the notation $floor.l x floor.r$. The *ceiling function* is a related function, denoted by $ceil.l x ceil.r$.

#definition(number: "1.4 fractional part")[
  The *fractional part* of a real number $x$, denoted by ${x}$, is the difference between $x$ and $[x]$.

  $ {x}=x-[x] $
]

= 1.3 Diophantine Approximation

