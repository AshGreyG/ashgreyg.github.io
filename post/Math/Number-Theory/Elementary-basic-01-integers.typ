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

#align(center, text(17pt)[
  = Elementary Number Theory (1): Integers
])

= 1 Number and Sequences

= 1.1 Numbers

The integers are the numbers in the set ${...,-3,-2,-1,0,1,2,3,...}$. Every 
nonempty set of positive integers has a least element. That is called 
*well-ordering* property (notice this is an axiom of set theory), we say that
 the set of positive integers is *well ordered*. However the set of all integers
  is not well ordered, as there are sets of integers without a smallest element.

Another important class of numbers in the number theory is the set of numbers that 
can be written as *ratios* of integers.

#definition(number: "1.1 rational")[
  The real number $r$ is *rational* if there are integers $p$ and $q$ such that 
  $r=p\/q$. If $r$ is not rational, it is *irrational*.
]

Note that every integer $n$ is a rational number because $n=n\/1$.

#theorem(number: "1.1")[
  $sqrt(2)$ is irrational.
]

#proof[
  Suppose that $sqrt(2)$ were rational. Then there would exist positive integers $a$ 
  and $b$ such that $sqrt(2)=a\/b$. Consequently, the set 
  $S={k sqrt(2) | k in ZZ^+ ∧ k sqrt(2) in ZZ^+}$ is a nonempty set of positive integers. 
  Therefore, by the well-ordering property, $S$ has a smallest element, we can denote 
  it as $s=t sqrt(2)$. Here $s$ and $t$ are both integers.
  
  We have $s sqrt(2)-s=s sqrt(2)-t sqrt(2)=(s-t)sqrt(2)$. Because $s sqrt(2)=2t$ and $s$ 
  are both integers, $s sqrt(2) -s=(s-t)sqrt(2)$ must also be an integer. Furthermore, 
  $s sqrt(2)-s=s(sqrt(2)-1)$ is also positive, and it's less than $s$, because $sqrt(2) < 2$. 
  This contradicts the choice of $s$ as the smallest positive integer in $S$. So it follows 
  that $sqrt(2)$ is irrational.
]

#definition(number: "1.2 algebraic")[
  A number $α$  is *algebraic* if it is the root of a polynomial with integer coefficients. 
  That is, $α$ is algebraic if there exist integers $a_0,...,a_n$ such that

  $ a_n α^n+a_(n-1) α^(n-1)+dots.c+a_0=0 $

  The number $alpha$ is called *transcendental* if it is not algebraic.
]

Note that every rational number is algebraic. This follow from the fact that the number $a\/b$, 
where $a$ and $b$ are integers and $b!=0$, is the root of $b x-a=0$.

= 1.2 The Greatest Integer Function

#definition(number: "1.3 greatest integer")[
  The *greatest integer* of a real number $x$, denoted by $[x]$, is the largest integer less 
  than or equal to $x$. That is, $[x]$ is the integer satisfying

  $ [x]<=x<[x]+1 $
]

The greatest integer function is also known as the *floor function*, computer scientists usually 
use the notation $⌊ x ⌋$. The *ceiling function* is a related function, denoted by $⌈ x ⌉$.

#definition(number: "1.4 fractional part")[
  The *fractional part* of a real number $x$, denoted by ${x}$, is the difference between $x$ and $[x]$.

  $ {x}=x-[x] $
]

= 1.3 Diophantine Approximation

We know that the distance of a real number to the integer closest to it is 
at most $1\/2$. Diophantine approximation studies the questions that involve the 
approximation of real numbers by rational numbers.

#theorem(number: "1.2 The Pigeonhole Principle")[
  If $k+1$ or more objects are placed into $k$ boxes, then at least one box contains 
  or more of the objects.
]

#proof[
  If none of the $k$ boxes contains more than one object, than the total number of 
  objects would be at most $k$. This contradiction shows that one of the boxes contains at 
  least two or more of the objects.
]

#theorem(number: "1.3 Dirichlet's Approximation Theorem")[
  If $α$ is a real number and $n$ is a positive integer, then there exist integers $a$ and 
  $b$ with $1 <= α <= n$ such that $|a α - b| < 1\/n$.
]

#proof[
  Consider the $n+1$ numbers $0,{α},{2α},dots.c,{n α}$. These $n+1$ numbers are the fractional 
  parts of the numbers $j α$, here $j=0,1,dots.c,n$, so that $0 <= {j α} < 1$ for 
  $j=0,1,dots.c,n$. Each of these $n+1$ numbers lies in one of the $n$ disjoint intervals 

  $ [0,1/n),[1/n,2/n),dots.c,[(j-1)/n,j/n),[(n-1)/n,1) $

  Because there are $n+1$ numbers under consideration, but only $n$ intervals, the Pigeonhole 
  principle tells us that at least two of these numbers lie in the same interval. Because 
  each of these intervals have length $1\/n$ and does not include its right endpoint. 
  So exist integers $j$ and $k$ with $0 <= j < k <= n$ such that

  $ {k α} - {j α} < 1/n $

  We now show that when $a=k-j$, the product $a α$ is within $1\/n$ of the integer $b=[k α]-[j α]$:

  $ |a α - b| & = |(k-j)α -([k α] - [j α])| \
    & = |(k α - [k α])-(j α - [j α])| \
    & = |{k α} - {j α}| \
    & < 1/n $

  Note that because $0 <= j < k <= n$, we have $1 <= a=k-j <= n$. Consequently, we have found 
  integers $a$ and $b$ with $1<=a<=n$ and $|a α -b|<1\/n$, as desired.
]

= 1.4 Sequences

A *sequence* ${a_n}$ is a list of numbers $a_1,a_2,a_3,dots.c$. Note that we can define a 
sequence with an initial term $a_0$.

#definition(number: "1.5 Geometric Progression")[
  A *geometric progression* is a sequence of the form $a,a r,a r^2,a r^3,dots.c,a r^k,dots.c$, 
  where $a,r in RR$, $a$ is the *initial term*, $r$ is the *common ratio*.
]

For example, the sequence ${a_n}$ where $a_n=3 dot 5^n$ is a geometric sequence with 
initial term $3$ and common ratio $5$.

#definition(number: "1.6 Arithmetic Progression")[
  An *arithmetic progression* is a sequence of the form $a,a+d,a+2d,dots.c,a+n d,dots.c$, 
  where $a,d in RR$, $a$ is the *initial term*, $d$ is the *common difference*.
]

For example, the sequence ${a_n}$ where $a_n=3n+1$ is an arithmetic sequence with initial term $4$ and common difference $3$.

#definition(number: "1.7 Countable Set")[
  A set is *countable* if it is finite or if it is infinite and there exists a one-to-one 
  correspondence between $ZZ^+$ and the set. A set is not countable is called *uncountable*.
]

An infinite set $S$ is countable if and only if its elements can be listed as the terms 
of a sequence indexed by the set of positive integers. A one-to-one correspondence 
$f:ZZ^+ |-> S$ is exactly the same as a listing of the elements of the set in a sequence 
$a_1,a_2,dots.c,a_n,dots.c$, where $a_i=f(i)$.

#theorem(number: "1.4")[
  The set of rational numbers is countable.
]

#proof[
  There is an informal proof from Cantor, he lists $1,2,3,dots.c$ (they will form the 
  numerators) from left to right, $1,2,3,dots.c$ (they will form the denominators) 
  from top to bottom, they makes a matrix that represents all the rational numbers:

  #figure(
    diagram(
      let gcd(x, y) = {
        while (y != 0) {
          let tmp = x;
          x = y;
          y = tmp - int(tmp / y) * y;
          // y = tmp % y, Typst doesn't support mod operator
        }
        return x;
      },

      // Define gcd function

      let unit = 4 / 5,
      let width = 5,
      for x in range(1, width) {
        node((x * unit, 0), str(x))
      },
      for y in range(1, width) {
        node((0, y * unit), str(y))
      },
      for y in range(1, width) {
        for x in range(1, width) {
          if (gcd(x, y) == 1) {
            node(
              (x * unit, y * unit), 
              $ #x / #y $, 
              name: label(str(x) + "-" + str(y))
            )
          } else {
            node(
              (x * unit, y * unit), 
              $ cancel(#x / #y) $,
              name: label(str(x) + "-" + str(y))
            )
          }
        }
      },

      // Draw the integers and rational numbers in Cantor proof

      let n = 1,  // n: numerator
      let d = 2,  // d: denominator
      let count = 2,
      let direction = -1,
      let last_n = 1,
      let last_d = 1,

      while (count <= width * (width - 1) / 2) {
        edge(
          label(str(last_n) + "-" + str(last_d)),
          label(str(n) + "-" + str(d)),
          "->"
        )
        last_n = n;
        last_d = d;
        if (n == 1 and direction == 1) {
          d += 1;
          direction = -1;
        } else if (d == 1 and direction == -1) {
          n += 1;
          direction = 1;
        } else {
          n += direction * (-1);
          d += direction;
        }
        
        count += 1;
      },

    ),
    caption: [
      Using Typst to draw the Cantor proof
    ]
  )

  #figure(
    image("Elementary-basic-01-integers-01.svg"),
    caption: [
      Using #link("https://github.com/AshGreyG/To-Learn-By-Books/blob/main/Math/Number-Theory/Elementary-Number-Theory-and-Its-Application/01-Cantor.py")[Python] to generate the Cantor proof
    ]
  )
]

= 2 Sums and Products

