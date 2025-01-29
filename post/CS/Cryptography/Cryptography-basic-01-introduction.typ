#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Linear Algebra (1): Vector Spaces")

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let definition = thmbox("definition", "Definition", fill: rgb("#e8e8f8"))

#let proof = thmproof("proof", "Proof")

#align(center, text(17pt)[
  = Modern Cryptography (1): Introduction
])

= 1 The Setting of Private-Key Encryption

Classical cryptography was concerned with designing and using *codes* (also called *ciphers*) that enable two parties to communicate secretly in the presence of an eavesdropper who can monitor all communication between them.

In modern parlance, codes are called *encryption schemes*. Security of all classical encryption schemes relied on a secret -- a *key* -- shared by the communication parties in advance and unknown to the eavesdropper. This scenario is known as the *private-key* or *shared- / private-key* setting.

One party can send a message, or *plaintext*, to the other by using the shared key to *encrypt*, the message and thus obtain a *ciphertext* that is transmitted to the receiver. The receiver uses the same key to *decrypt* the ciphertext and recover the original message.

Note the same key is used to convert the plaintext into a ciphertext and back, and that's called *symmetric-key*, where the symmetric lies in the fact that both parties hold the same key that is used for encryption and decryption.

#definition(number: "1.1 The syntax of encryption")[
  Formally, a private-key encryption scheme is defined by specifying a *message space* $cal("M")$ along with three algorithms: 
  + A procedure for *generating keys* $sans("Gen")$ is a probabilistic algorithm that outputs a key $k$ chosen according to some distribution.
  + A procedure for *encrypting* $sans("Enc")$ takes as input a key $k$ and a message $m$ and outputs a ciphertext $c$. We denote $sans("Enc")_k (m)$ the encryption of the plaintext $m$ using the key $k$.
  + A procedure for *decrypting* $sans("Dec")$ takes as input a key $k$ and a ciphertext $c$ and outputs a plaintext $m$. We denote the decryption of the ciphertext $c$ using the key $k$ by $sans("Dec")_k (c)$.

  An encryption scheme must satisfy the following correctness requirement: for every key $k$ output by $sans("Gen")$ and every message $m in cal("M")$, it holds that

  $ sans("Dec")_k (sans("Enc")_k (m))=m $

  The set of all possible keys output by the key-generation algorithm is called the *key space* and is denoted by $cal("K")$. Almost always, $sans("Gen")$ simply chooses a uniform key from the key space.
]

First, $sans("Gen")$ is run to obtain a key $k$ that the parties share. Later, when one party wants to send a plaintext $m$ to the other, she computes $c:= sans("Enc")_k (m)$ and sends the resulting ciphertext $c$ over the public channel to the other party. Upon receiving $c$, the other party computes $m:= sans("Dec")_k (c)$ to recover the original plaintext.

If an eavesdropper knows the algorithm $sans("Dec")$ as well as the key $k$ shared by the two communicating parties, then that adversary will be able to decrypt any ciphertexts transmitted by those parties. Auguste Kerckhoffs argued the opposite in a paper he wrote elucidating several design principles for military ciphers. One of the most important of these, now known simply as *Kerckhoffs's principle*:

#definition(number: "1.2 Kerckhoffs's principle")[
  The cipher method must not be required to be secret, and it must be able to fall into the hands of the enemy without inconvenience. *That is, an encryption scheme should be designed to be secure even if an eavesdropper knows all the details of the scheme, so long as the attacker doesn't know the key being used.*
]

Kerckhoffs's principle demands that *security rely solely on secrecy of the key*. 

= 2 Historical Ciphers and Their Cryptanlaysis

Plaintext characters are written in $mono("lower case")$ and ciphertext characters are written in $mono("UPPER CASE")$.

#definition(number: "2.1 The shift cipher")[
  The *shift cipher* can be viewed as a keyed variant of *Caesar's cipher*. Specially, in the shift cypher the key $k$ is a number between 0 and 25. 
  + Algorithm $sans("Gen")$ outputs a uniform key $k in {0,dots.c,25}$;
  + 
]