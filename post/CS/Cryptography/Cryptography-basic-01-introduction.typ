#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "Modern Cryptography (1): Introduction")
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
  = Modern Cryptography (1): Introduction
])

= 1 The Setting of Private-Key Encryption

Classical cryptography was concerned with designing and using *codes* (also 
called *ciphers*) that enable two parties to communicate secretly in the 
presence of an eavesdropper who can monitor all communication between them.

In modern parlance, codes are called *encryption schemes*. Security of all 
classical encryption schemes relied on a secret -- a *key* -- shared by the 
communication parties in advance and unknown to the eavesdropper. This 
scenario is known as the *private-key* or *shared- / private-key* setting.

One party can send a message, or *plaintext*, to the other by using the 
shared key to *encrypt*, the message and thus obtain a *ciphertext* that is 
transmitted to the receiver. The receiver uses the same key to *decrypt* the 
ciphertext and recover the original message.

Note the same key is used to convert the plaintext into a ciphertext and back, 
and that's called *symmetric-key*, where the symmetric lies in the fact that both 
parties hold the same key that is used for encryption and decryption.

#definition(number: "1.1 The syntax of encryption")[
  Formally, a private-key encryption scheme is defined by specifying a 
  *message space* $cal("M")$ along with three algorithms: 
  + A procedure for *generating keys* $sans("Gen")$ is a probabilistic algorithm 
    that outputs a key $k$ chosen according to some distribution.
  + A procedure for *encrypting* $sans("Enc")$ takes as input a key $k$ and a 
    message $m$ and outputs a ciphertext $c$. We denote $sans("Enc")_k (m)$ the 
    encryption of the plaintext $m$ using the key $k$.
  + A procedure for *decrypting* $sans("Dec")$ takes as input a key $k$ and a 
    ciphertext $c$ and outputs a plaintext $m$. We denote the decryption of the 
    ciphertext $c$ using the key $k$ by $sans("Dec")_k (c)$.

  An encryption scheme must satisfy the following correctness requirement: for 
  every key $k$ output by $sans("Gen")$ and every message $m in cal("M")$, it holds that

  $ sans("Dec")_k (sans("Enc")_k (m))=m $

  The set of all possible keys output by the key-generation algorithm is called the 
  *key space* and is denoted by $cal("K")$. Almost always, $sans("Gen")$ simply 
  chooses a uniform key from the key space.
]

First, $sans("Gen")$ is run to obtain a key $k$ that the parties share. Later, 
when one party wants to send a plaintext $m$ to the other, she computes 
$c:= sans("Enc")_k (m)$ and sends the resulting ciphertext $c$ over the public channel 
to the other party. Upon receiving $c$, the other party computes $m:= sans("Dec")_k (c)$ 
to recover the original plaintext.

If an eavesdropper knows the algorithm $sans("Dec")$ as well as the key $k$ shared by 
the two communicating parties, then that adversary will be able to decrypt any ciphertexts
transmitted by those parties. Auguste Kerckhoffs argued the opposite in a paper he wrote 
elucidating several design principles for military ciphers. One of the most important 
of these, now known simply as *Kerckhoffs's principle*:

#definition(number: "1.2 Kerckhoffs's principle")[
  The cipher method must not be required to be secret, and it must be able to fall into 
  the hands of the enemy without inconvenience. *That is, an encryption scheme should be 
  designed to be secure even if an eavesdropper knows all the details of the scheme, so 
  long as the attacker doesn't know the key being used.*
]

Kerckhoffs's principle demands that *security rely solely on secrecy of the key*. 

= 2 Historical Ciphers and Their Cryptanlaysis

Plaintext characters are written in $mono("lower case")$ and ciphertext characters are 
written in $mono("UPPER CASE")$.

#definition(number: "2.1 The shift cipher")[
  The *shift cipher* can be viewed as a keyed variant of *Caesar's cipher*. Specially, 
  in the shift cypher the key $k$ is a number between 0 and 25. 
  + Algorithm $sans("Gen")$ outputs a uniform key $k ∈ {0,⋯,25}$;
  + Algorithm $sans("Enc")$ takes a key $k$ and a plaintext and shifts each
    letter of the plaintext forward $k$ positions (wrapping around end of the
    alphabet).
  + Algorithm $sans("Dec")$ takes a key $k$ and a ciphertext and shifts every
    letter of the ciphertext *backwards* $k$ positions.

  Equate the English alphabet with the set ${0,⋯,25}$ . The message space
  $cal("M")$ is any finite sequence of integers from this set. Encryption of the
  message $m = m_1 ⋯ m_l$ (where $m_i ∈ {0,⋯,25}$) using key $k$ is given by

  $ sans("Enc")_k (m_1 ⋯ m_l) = c_1 ⋯ c_l space "where" c_i = [(m_i + k) mod 26] $

  The notation $[a mod N]$ denotes the remainder of $a$ upon division by $N$,
  with $0 ≤ [a mod N] < N$. We refer to the process mapping $a$ to $[a mod N]$
  as *reduction modulo $N$*. And decryption of a ciphertext $c = c_1 ⋯ c_l$
  using key $k$ is given by 

  $ sans("Dec")_k (c_1 ⋯ c_l) = m_1 ⋯ m_l space "where" m_i = [(c_i - k) mod 26] $
]

An attack that involves trying every possible key is called a *brute force* or
*exhaustive-search* attack. For an secure encryption it must not be vulnerable
to such an attack. This observation is known as the *sufficient key-space
principle*:

#definition(number: "2.2 Sufficient Key-space Principle")[
  Any secure encryption scheme must have a key space that is sufficiently
  large to make an exhaustive-search attack infeasible.
]

To protect against such attacks the key space must therefore be very large, of
size $2^70$. But the sufficient key-space principle gives a necessary condition
for security but not a sufficient one.

#definition(number: "2.3 Mono-alphabetic Substitution Cipher")[
  In the *mono-alphabetic substitution cipher* the key also defines a map on
  the alphabet, but the map is now allowed to be arbitrary subject only to the
  constraint that it be one-to-one so that decryption is possible. They key
  space thus consists of all *bijection* or *permutations* of the alphabet.

  + Algorithm $sans("Gen")$ generates a bijection $k$: $k : {0,⋯,25} ↦ {0,⋯,25}$
  + Algorithm $sans("Enc")$ use the bijection to map plaintext to ciphertext:

    $ sans("Enc")_k (m_1 ⋯ m_l) = k(c_1) ⋯ k(c_l) $

  + Algorithm $sans("Dec")$ use the inverse bijection of $k$ ($k^(-1)$) to
    decrypt the ciphertext, as:

    $ sans("Dec")_k (c_1 ⋯ c_l) = k^(-1)(c_1) ⋯ k^(-1)(c_l)) $
]

Assuming English alphabet is being encrypted (the text is grammatically correct
English writing), the key space is of size $26! ≈ 2^88$ but this doesn't mean
the cipher is secure: the mono-alphabetic substitution cipher can be attacked
by utilizing statistical patterns of the English language.

+ For any key, the mapping of each letter is fixed and so if $m_i$ is mapped
  to $k(m_i)$, then every appearance of $m_i$ in the plaintext will result in
  the appearance of $k(a_i)$ in the ciphertext.
+ The frequency distribution of individual letters in the English language is
  known. The frequencies of character in are then compared to the known letter
  frequencies of normal English text.

However, decrypt mono-alphabetic substitution cipher is not such a clear easy
way, it may use MCMC (Markov Chain Monte Carlo) algorithm.

// TODO: Here may cite a future note about MCMC

Associate the letters of the English alphabet with $0,⋯25$, let $p_i$ with
$0 ≤ p_i ≤ 1$, denote the letters of the $i$th letter in normal English text,
using the frequency table of English characters:

If given some ciphertext and let $q_i$ denote the frequency of the alphabet
in this ciphertext; $q_i$ is simply the number of occurrences of the $i$th
letter of the alphabet in the ciphertext divided by the length of the ciphertext.
If the key is $k$, let $q_(i + k)$ denote after mapping $k$, the $i$th letter
is mapped to the $[(i + k) mod 26]$th letter, then $p_i ≈ q_([(i + k) mod 26])$

$ I_j := ∑^25_(i = 0) p_i ⋅ q_([(i + j) mod 26]) $

for each value of $j ∈ {0,⋯,25}$, then for real key $k$

$ I_k = ∑^25_(i = 0) p_i ⋅ q_([(i + k) mod 26]) ≈ ∑^25_(i = 0) p_i ^ 2 ≈ 0.065 $

This leads to a key recovery attack that is easy to automate: compute $I_j$ for
all $j$ and then output the value $k$ for which $I_k$ is closest to $0.065$.

#definition(number: "2.4 Vigenere Cipher")[
  *Poly-alphabetic substitution cipher* is an algorithm that the key instead 
  defines a mapping that is applied on blocks of plaintext characters. Here
  a key may map the 2-character block $mono("ab")$ to $mono("DZ")$ or map
  $mono("ac")$ to $mono("TY")$. Poly-alphabetic substitution ciphers *smooth
  out* the frequency distribution of characters and makes it harder to perform
  statistical analysis.

  + Algorithm $sans("Gen")$ gives a set of maps from characters block to another
    block: $σ : m_1 ⋯ m_s ↦ c_1 ⋯ c_t$, where $m_i, c_i ∈ {0,⋯,25}$. And the
    set (substitution rules, or the rules of key $k$) should be

    $ k = {σ | σ : m_1 ⋯ m_s ↦ c_1 ⋯ c_t, space m_i, c_i ∈ {0,⋯,25}} $

  + Algorithm $sans("Enc")$ use the substitution rules to encrypt messages:

    #pseudocode(
      [Algorithm 1 Poly-alphabetic Substitution Cipher],
      [
        + *procedure* #smallcaps("Poly-alphabetic Substitution Cipher") (M)
          + $n$ ← $sans("length")(upright("M"))$
          + $i$ ← $0$
          + *while* $i < n$ *do*
            + *for* $j$ *in* $S := {l | l = sans("length")(m), m ∈ sans("ran")(k)}$
              *do*
              + ▷ Here set (or list) $S$ consists of different length $s$ of
                $m_1 ⋯  m_s$ in substitution rules.
              + *if* $upright("M")[i : i + j - 1] ∈ M := sans("ran")(k)$ *do*
      ]
    )

  The Vigenere cipher is a special case of the poly-alphabetic substitution
  cipher, and it is also called *poly-alphabetic shift cipher*.
]
