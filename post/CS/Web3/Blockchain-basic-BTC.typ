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

= 2.1 Hash Pointer and Blockchain

*Hash pointer* is a pointer to a memory block, but different from the traditional pointer, it stores the Hash value of the memory block. If the content of this memory block changes, the Hash value will also change.

#align(center)[
  #figure(
    diagram(
      node((0,0), shape: rect, stroke: 0.5pt, width: 30pt, height: 30pt, name: <memory>, fill: teal.lighten(80%)),
      node((0.7,0), "Hash value", name: <hash-value>),
      node((1,-0.7), "Hash pointer", name: <hash-pointer>),

      edge(<hash-pointer>, <memory.east>, "->"),
      edge(<hash-pointer>, <hash-value>, "->")
    ),
    caption: "Hash pointer"
  )
]

Blockchain is a *linked list using Hash pointer*, each node stores a prev pointer to its previous node. Here is an example of blockchain:

#align(center)[
  #figure(
    diagram(
      let max = 5,
      for i in range(1, max + 1) {
        node((i - 1, 0), "Hp", shape: rect, stroke: 0.5pt, fill: red.lighten(90%), name: label(str(i)))
        
        if (i != 1) {
          edge(label(str(i)), label(str(i - 1)), "-|>")
        }
      },

      node((0.5, -1), "genesis block", name: <genesis>),
      node((max - 0.5, -1), "most recent block", name: <most-recent>),

      edge(<genesis>, <1>, "->"),
      edge(<most-recent>, label(str(max)), "->")
    ),
    caption: "Blockchain"
  )
]

Because every node on the blockchain stores the Hash pointer, whenever the content of some node $k$ changes, the Hash pointer to node $k$, which is stored by node $k+1$, will also change. Because node $k+1$ stores the Hash pointer to node $k$ and this Hash pointer has also changed. Continue this analysis procedure, and we will get this conclusion: *when the content of node $k$ changes*,

$ forall k + 1 <= i <= sans("most recent block"), upright(H)(i) != upright(H)(i)_(sans("original")) $

So we can detect the Hash value (or Hash pointer) to the most recent block to detect every tiny change on the blockchain. This is called *tamper-evident log*.

= 2.2 Merkle Tree

*Merkle tree* is a binary tree using Hash pointer, each node stores two Hash pointers to the two leaf nodes. We can draw a figure to describe the Merkle tree:

#align(center)[
  #figure(
    diagram(
      node-shape: rect,
      node-stroke: 0.5pt,
      node-fill: red.lighten(90%),

      // Hash pointer nodes

      let dis = 1.6,
      let height = 0.8,
      let gap = 0.8,
      let data_gap = 0.5,
      let data_width  = 20pt,
      let data_height = 40pt,
      let content_str = "Hp   Hp",
      let left_str = text("Hp", fill: red) + "   Hp",
      let right_str = "Hp   " + text("Hp", fill: red),

      node((0,0), right_str, name: <0>, fill: yellow.lighten(80%)),
      node((+dis, height), content_str, name: <0-2>),
      node((-dis, height), left_str, name: <0-1>, fill: yellow.lighten(80%)),
      node((-dis - gap, height * 2), content_str, name: <0-1-1>),
      node((-dis + gap, height * 2), left_str, name: <0-1-2>, fill: yellow.lighten(80%)),
      node((+dis + gap, height * 2), content_str, name: <0-2-2>),
      node((+dis - gap, height * 2), content_str, name: <0-2-1>),

      // data blocks

      node((-dis - gap - data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-1>),
      node((-dis - gap + data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-2>),
      node((-dis + gap + data_gap, height * 3), height: data_height, width: data_width, fill: yellow.lighten(80%), name: <data-3>),
      node((-dis + gap - data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-4>),
      node((+dis - gap - data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-5>),
      node((+dis - gap + data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-6>),
      node((+dis + gap - data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-7>),
      node((+dis + gap + data_gap, height * 3), height: data_height, width: data_width, fill: teal.lighten(80%), name: <data-8>),

      edge(<0>, <0-1>, "-|>"),
      edge(<0>, <0-2>, "-|>"),
      edge(<0-1>, <0-1-1>, "-|>"),
      edge(<0-1>, <0-1-2>, "-|>"),
      edge(<0-2>, <0-2-1>, "-|>"),
      edge(<0-2>, <0-2-2>, "-|>"),
      edge(<0-1-1>, <data-1>, "-|>"),
      edge(<0-1-1>, <data-2>, "-|>"),
      edge(<0-1-2>, <data-3>, "-|>"),
      edge(<0-1-2>, <data-4>, "-|>"),
      edge(<0-2-1>, <data-5>, "-|>"),
      edge(<0-2-1>, <data-6>, "-|>"),
      edge(<0-2-2>, <data-7>, "-|>"),
      edge(<0-2-2>, <data-8>, "-|>"),

    ),
    caption: "Merkle Tree"
  )
]

The blue blocks are called *data blocks*, the blocks that store two hash pointers are called *Hash pointer blocks*, and the root of this binary tree is called the *root Hash*. Every data block can store a trade record. Every block in blockchain has two components: *block header* and *block body*. Block header stores the root Hash of a Merkle tree on this block, block header doesn't store the detailed information of trade records.

There are two kinds of node:
- *Full node*: full node stores the detailed trade records and the whole Merkle tree.
- *Light node*: light node only stores the Hash value of this light node on the Merkle tree.

The yellow block in data blocks is a light node, and when it wants to verify if a trade record is written in it, it will request the full node to offer the Hash value of other branches (marked as #text("Hp", fill: red) in the figure above) and calculate the Hash value of each node in the path from this yellow block to the root. Finally, it will compare the calculated Hash value of root node and the stored Hash value of root node. This procedure is called *proof of membership*, and the time complexity is $O(log n)$, here $n$ is the quantity of data blocks.

= 3 Agreement

Consider that a central bank wants to issue some virtual currency, but we can copy 