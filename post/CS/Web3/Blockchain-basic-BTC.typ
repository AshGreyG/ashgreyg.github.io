#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Blockchain: BTC")

#align(center, text(17pt)[
  = Blockchain: BTC
])

= 1 Principles of Cryptology in BTC

= 1.1 Hash Function

*Cryptographic Hash* function in Cryptology has two properties:
+ *collision resistance*: There exits two inputs in the input space $x,y$, they are not equal, $x != y$, but through the Hash function, their outputs are same $upright(H)(x)=upright(H)(y)$. The real world is the input space, it can be infinitely large, but the output space of Hash function is finite. But Hash function can guarantee that it is extremely hard or nearly impossible to find this kind of $x$ and $y$, so we say that Hash function is a kind of *message digest* function.

  For a message $m$, then $upright(H)(m)$ can be described as the *digest* of message $m$. So if message $m$ is changed by someone, then we can use the $upright(H)(m)$ to detect it.

  md5 is a kind of Hash function, but we have found the way to produce the Hash collision of md5 Hash function. And sometimes we want to avoid Hash collision when we detect if two messages are different, we may append a nonce to the original message:

  $ m union sans("nonce") arrow.long.r upright(H)(m union sans("nonce")) $

+ *hiding*: Hash function can calculate the $upright(H)(m)$ from message $m$, but we can't calculate $m$ from $upright(H)(m)$. Hash function is one-way. The hiding property needs the input space of this Hash function large enough and uniform.

+ *puzzle friendly*: The Hash function used in Bitcoin has the third extra property. The Bitcoin mining is the calculation procedure below:

  $ sans("block-header") union sans("nonce") arrow.long.r upright(H)(sans("block-header") union sans("nonce")) <= sans("target") $

  We need to find the $sans("nonce")$ that satisfies the condition above. And this property "puzzle friendly" means that there is only one way to calculate the $sans("nonce")$: *brute force*, and that's called the *proof of work*. Bitcoin is *difficult to solve, but easy to verify*.

The Hash function Bitcoin used is *SHA-256* (Secure Hash Algorithm).

= 1.2 Signature

The account in Bitcoin doesn't need to be approved by some centralized banks, we only need to create the public key and private key. These terms come from the *asymmetric encryption algorithm*, we can draw two figures to distinguish symmetric encryption and asymmetric encryption:

#align(center)[
  #import fletcher.shapes: pill, parallelogram, diamond, hexagon, ellipse
  #figure(
    diagram(
      node((0,0), "Alice", shape: parallelogram, stroke: 0.5pt, name: <alice>, fill: teal.lighten(80%)),
      node((1.5,0), "message", shape: ellipse, stroke: 0.5pt, name: <message>, fill: black.lighten(90%)),
      node((3,0), "Bob", shape: parallelogram, stroke: 0.5pt, name: <bob>, fill: red.lighten(80%)),

      edge(<alice.north>, <message.north>, "->", $sans("encryption key")$, bend: +40deg),
      edge(<message.south>, <bob.south>, "->", $sans("decryption key")$, bend: -40deg),
   ),
    caption: "Symmetric Encryption",
  )
]

In asymmetric encryption, the encryption key and decryption key are the same. If the key is stolen when it is transporting through the environment, the information won't be safe anymore. But the asymmetric encryption solves this problem:

#align(center)[
  #import fletcher.shapes: pill, parallelogram, diamond, hexagon, ellipse
  #figure(
    diagram(
      node((0,0), "Alice", shape: parallelogram, stroke: 0.5pt, name: <alice>, fill: teal.lighten(80%)),
      node((1.5,0), "message", shape: ellipse, stroke: 0.5pt, name: <message>, fill: black.lighten(90%)),
      node((3,0), "Bob", shape: parallelogram, stroke: 0.5pt, name: <bob>, fill: red.lighten(80%)),

      edge(<alice.north>, <message.north>, "->", $sans("public key") text("of Bob")$, bend: +40deg),
      edge(<message.south>, <bob.south>, "->", $sans("private key") text("of Bob")$, bend: -40deg),
   ),
    caption: "Asymmetric Encryption",
  )
]

In Bitcoin trade, asymmetric encryption is used in *signature*. For example, Alice wants to give 10 bitcoins to Bob, she posts this trade to the blockchain. This procedure needs her to use her private key to signature the trade. The others on the blockchain can verify this using Alice's public key.

Creating the private and public key needs a good source of randomness, under this situation, creating the same private and public key with other's is impossible.

= 2 Data Structure