#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

#show: book-page.with(title: "Abstract Algebra (1): Categories Theory")
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
#show math.equation.where(block: true): set text(size: 14pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = Abstract Algebra (1): Categories Theory
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
+ $ℕ$: the set of *natural numbers*;
+ $ℤ$: the set of *integers*;
+ $ℚ$: the set of *rational numbers*;
+ $ℝ$: the set of *real numbers*;
+ $ℂ$: the set of *complex numbers*.

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
+ $×$: the *Cartesian product*.

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
finite, clearly $|S × T| = |S| × |T|$

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

for the union, intersection, disjoint union. product of all sets in $scr(S)$.

// Unfortunately, ∪ and ∩ can't be recognized in displayed math environment

= 1.4 Equivalence relations, partitions, quotients

A *relation* on elements of a set $S$ is some special affinity among selections
of elements of $S$. For example, the relation $<$ on the set $ZZ$ is a way to
compare the size of two integers. A relations on a set $S$ is simply a subset
$R$ of the Cartesian product $S × S$. If $(a,b) ∈ R$, we say that $a$ and $b$
are related by $R$, and write

$ a R b $

The prototype of a well-behaved relation is $=$, which corresponds to the diagonal

$ {(a,b) ∈ S × S | a = b} = {(a,a) | a ∈ S} ⊆ S × S $

Three properties of this very special relation turn out to be particularly important:
if $∼$ denotes for a moment the relation $=$ of equality, then $∼$ satisfies
+ *Reflexivity*: $(∀ a ∈ S) a ∼ a$;
+ *Symmetry*: $(∀ a ∈ S)(∀ b ∈ S) a ∼ b => b ∼ a$;
+ *Transitivity*: $(∀ a ∈ S)(∀ b ∈ S)(∀ c ∈ S), (a ∼ b ∧ b ∼ c) => a ∼ c$.

#definition(number: "1.1")[
  An *equivalence relation* on a set $S$ is any relation $∼$ satisfying these three
  properties.
]

A *partition* of $S$ is a family of disjoint nonempty subsets of $S$, whose union is
$S$. For example, $scr(S)={{1,4,7},{2,5,8},{3,6},{9}}$ is a partition of the set
${1,2,3,4,5,6,7,8,9}$. Here is how to get a partition of $S$ from a relation $∼$ on
$S$: for every element $a ∈ S$, the *equivalence classes* of $a$ is the subset of
$S$ defined by

$ [a]_∼ := {b ∈ S | b ∼ a} $

then the equivalence classes form a partition $scr(S)_∼$ of $S$.

#proof[
  Let $S$ be a set with an equivalence relation $∼$. Consider the family of equivalence
  classes respect to $∼$:

  $ scr(S)_∼ = {[a]_∼ | a ∈ S} $

  Consider an element $[a]_∼$ of $scr(S)_∼$. By the reflexivity of equivalence relation,
  we know $[a]_∼$ is not empty. Consider $a$ and $b$ are two different elements of $S$,
  and $a ≁ b$. Using contradiction to prove the proposition: consider there is an element
  $x ∈ [a]_∼ ∩ [b]_∼$, then $x ∼ a$ and $x ∼ b$. By the transitivity of equivalence
  relation, we know $a ∼ b$, and this is a contradiction. Hence all the elements of
  $scr(S)_∼$ are disjoint. For $x ∈ S$, we know $x ∈ [x]_∼ ∈ scr(S)_∼$, then

  $ union.big_([a]_∼ ∈ scr(S)_∼)[a]_∼ = S $

  so the equivalence classes form a partition $scr(S)_∼$ of $S$.
]

Given a partition $scr(S)$ on a set $S$, it is corresponding to an equivalence relation
on $S$. So the notions of equivalence classes on $S$ and partition of $S$ are really
equivalent.

#proof[
  Given a partition $scr(S)$ on a set $S$, we will show how to define an equivalence
  relation $∼$ such that $scr(S)_∼ = scr(S)$

  For $a,b ∈ S$, $a ∼ b$ if and only if there exists a set $T in scr(S)$ such that
  $a ∈ T$ and $b ∈ T$. Now we can check $∼$ is an equivalence relation:

  + Reflexivity: $∃ T ∈ scr(S), a ∈ T ∧ a ∈ T <=> a ∼ a$;
  + Symmetry: $a ∼ b <=> ∃ T ∈ scr(S), a ∈ T ∧ b ∈ T <=> b ∼ a$;
  + Transitivity:

    $ a ∼ b ∧ b ∼ c
      <=> & (∃ T_1 ∈ scr(S), a ∈ T_1 ∧ b ∈ T_1) ∧
            (∃ T_2 ∈ scr(S), b ∈ T_2 ∧ c ∈ T_2) \
       => & ∃ T_1, T_2 ∈ scr(S), (a ∈ T_1) ∧ (b ∈ T_1 ∩ T_2) ∧ (c ∈ T_2) \
       => & ∃ T_1, T_2 ∈ scr(S), (a ∈ T_1) ∧ (c ∈ T_2) ∧ (T_1 ∩ T_2 != ∅) \
       => & ∃ T_1, T_2 ∈ scr(S), (a ∈ T_1) ∧ (c ∈ T_2) ∧ (T_1 = T_2) \
       => & ∃ T_1, T_2 ∈ scr(S), (a ∈ T_1) ∧ (c ∈ T_1) \
      <=> & a ∼ c $

  So we know $∼$ is an equivalence relation. Now we want prove that $scr(S)=scr(S)_∼$:

  + $scr(S) ⊆ scr(S)_∼$: Note that

    $ T ∈ scr(S)
      => & ∀ a, b ∈ T, a ∼ b \
     <=> & T ∈ scr(S)_∼ $

    The first deduction is from the our definition of relation $∼$.

  + $scr(S)_∼ ⊆ scr(S)$: Given any $[a]_∼ ∈ scr(S)_∼$, there exists $T ∈ scr(S)$
    such that $a ∈ T$, we have

    $ ∀ a' ∈ T => a ∼ a' <=> a' ∈ [a]_∼  $

    So we get $T ⊆ [a]_∼$. Also we have

    $ a' ∈ [a]_∼
      <=> & ∃ P ∈ scr(S), (a ∈ P) ∧ (a' ∈ P) \
       => & ∃ P ∈ scr(S), (a ∈ T ∩ P) ∧ (a' ∈ P) \
       => & ∃ P ∈ scr(S), (T ∩ P != ∅) ∧ (a' ∈ P) \
       => & ∃ P ∈ scr(S), (T = P) ∧ (a' ∈ P) \
       => & a' ∈ T $

    So we get $[a]_∼ ⊆ T$, so $[a]_∼ = T ∈ scr(S)$. Therefore $scr(S)_∼ ⊆ scr(S)$.
    We can finally conclude that $scr(S)$ and $scr(S)_∼$ is equal.
]

For example, for a partition ${{1,2},{3,4},{5}}$ of set ${1,2,3,4,5}$, we can find
the equivalence relation $∼$ whose equivalence classes form the partition that we want:

$ {(1,1),(2,2),(1,2),(2,1),(3,3),(4,4),(3,4),(4,3),(5,5)} $

#definition(number: "1.2")[
  The *quotient* of the set $S$ with respect to (w.r.t) the equivalence relation $∼$ is
  the set

  $ S\/ ∼ := scr(S)_∼ $
]

= 2 Functions Between Sets

Sets interact with each other through *functions*. A function $f$ is captured by the
information of which element $b$ of $B$ is the image of any given element $a$ of $A$.
A function is the subset of $A × B$:

$ Γ_f := {(a,b) ∈ A × B | b = f(a)} ⊆ A × B $

This set $Γ_f$ is the *graph* of $f$. Not all subsets $Γ ⊆ A × B$ correspond to
functions, only subsets that satisfy

$ (∀ a ∈ A)(∃! b ∈ B) space.en (a,b) ∈ Γ_f $

To announce that $f$ is a function from a set $A$ to a set $B$, we can write $f:A -> B$,
or draws the following diagram:

#figure(
  diagram($
    A edge(f, ->) & B
  $)
)

The action of a function $f:A -> B$ on an element $a ∈ A$ is sometime indicated by a
decorated arrow like $a |-> f(a)$. The collection of all functions from a set $A$ to
a set $B$ is itself a set denoted $B^A$, we can view $B^A$ as a special subset of the
power set of $A × B$.

Every set $A$ comes equipped with a very special function, whose graph is the diagonal
in $A × A$: the *identity function* on $A$:

$ "id"_A : A -> A $

More generally, the inclusion of any subset $S$ of a set $A$ determines a function $S -> A$, simply
sending every element $s$ of $S$ to itself in $A$.

If $S$ is a subset of $A$, we denote $f(S)$ the subset of $B$ defined by

$ f(S) := {b ∈ B | (∃ a ∈ S) b = f(a)} $

$f(S)$ is the subset of $B$ consisting of all elements that are images of elements
of $S$ by the function $f$. The largest such subset, that is $f(A)$, is called the image
of $f$, denoted $"im" f$.

$f|_S$ denotes the restriction of $f$ to the subset $S$: this is the function $S -> B$
defined by

$ (∀ s ∈ S): f|_S (s) = f(s) $

That is, $f|_S$ is the composition $f ∘ i$ where $i: S -> A$.
