#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Abstract Algebra (1): Set Theory and Categories")

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", fill: rgb("#e8e8f8"))

#let proof = thmproof("proof", "Proof")

#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

#align(center, text(17pt)[
  = Abstract Algebra (1): Set Theory and Categories
])

= 1 Naive Set Theory

= 1.1 Sets

The notion of *Set* formalizes the intuitive idea of 'collection of objects'.
A set is determined by the *elements* it contains: two sets $A$, $B$ are equal
(written as $A=B$) if and only if they contain precisely the same elements.

'What is an *element*?' is a forbidden question in naive set theory: the buck
must stop somewhere. The elements of a set as elements $s$ of some larger set
$S$, satisfying some property $P$. One may written as

$ A={s ∈ S | s "satisfies" P} $

+ $∅$: the *empty set*, containing no elements;
+ $NN$: the set of *natural numbers*;
+ $ZZ$: the set of *integers*;
+ $QQ$: the set of *rational numbers*;
+ $RR$: the set of *real numbers*;
+ $CC$: the set of *complex numbers*.

The term *singleton* is used to refer to any set consisting of precisely one
element. Thus ${1}$, ${2}$ and ${3}$ are different sets, but they are all
*singletons*.

+ $∃$ means *there exists...* (the existential quantifier), also $∃!$
  is used to mean *there exists a unique...*
+ $∀$ means *for all...* (the universal quantifier).

= 1.2 Inclusion of sets

We say that a set $S$ is a *subset* of a set $T$ if every element of $S$ is an
element of $T$. In symbols:

$ S ⊆ T $

$S ⊂ T$ means it does not exclude that $S$ and $T$ may be equal, and $S 
⊊ T$ means $S$ is properly contained in $T$, that is $S ⊂ T$ and
$S != T$. $S ⊆ T$ means that

$ ∀ s ∈ S => s ∈ T $

If $S ⊆ T$ and $T ⊆ S$, then $S=T$.

The symbol $|S|$ denotes the *number of elements* of $S$, if this number is finite.
Else, one writes $|S|=∞$. If $S$ and $T$ are finite, then

$ S ⊆ T => |S| <= |T| $

The subsets of a set $S$ form a set, called the *power set*, or *set of parts* of
$S$. For example, the power set of the empty set $emptyset$ consists of one element
${∅}$. The power set pf $S$ is denoted $scr(P)(S)$, a popular alternative is
$2^S$, and indeed

$ |scr(P)(S)| = 2^(|S|) $

is $S$ is finite.

= 1.3 Operations between sets

+ $∪$: the *union*;
+ $∩$: the *intersection*;
+ $⧵$: the *difference*;
+ $⨿$: the  *disjoint union*;
+ $×$: the *Cartesian product*;

The output of disjoint unions, Cartesian product operations may not be defined as a
*set*, rather as a set *up to isomorphisms of sets*, that is up to bijection. Roughly
speaking, the *disjoint-union* of two sets $S$ and $T$ is a set $S ⨿ T$ 
obtained by first producing $S'$ and $T'$ which are generated from the original sets
$S$ and $T$ (if $S ∪ T != ∅$), and they satisfy the property that
$S' ∪ T' = ∅$. We have $|S'| = |S|$ and $|T'| = |T|$, so $|S ⨿ T| = |S| + |T|$

The *cartesian product* of two sets $S$ and $T$: given $S$ and $T$, we let $S × T$ be
the set whose elements are the *ordered pairs* $(s,t)$ of elements of $S$ and $T$

$ S × T := {(s,t) "such that" s ∈ S, t ∈ T} $

The product $A × A$ of a set by itself is often denoted $A^2$. If $S$ and $T$ are
finite sets, clearly $|S × T| = |S| × |T|$

Also note that we can use products to obtain explicit the isomorphisms of sets as needed
for the disjoint union: for example, we could let

$ S' = {0} × S, T' = {1} × T $

guaranteeing that $S'$ and $T'$ are disjoint.

Those operations can be extended to operations on whole families of sets. 
If $S_1, ..., S_n$ are sets, we write

$ inter.big ^n_(i=1) S_i = S_1 ∩ S_2 ∩ ... ∩ S_n $

we use $scr(S)$ to denote a set of sets and we have

$ 
  union.big_(S ∈ scr(S))S, space.en inter.big_(S ∈ scr(S))S, space.en
  ∐_(S ∈ scr(S))S, space.en ∏_(S ∈ scr(S))S
$

// Unfortunately, ∪ and ∩ can't be recognized in displayed math environment