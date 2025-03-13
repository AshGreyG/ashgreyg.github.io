#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "/book.typ": book-page
#show: book-page.with(title: "Blockchain: BTC")

#align(center, text(17pt)[
  = Blockchain: BTC
])

= 1 Principles of Cryptology in BTC

= 1.1 Hash Function

*Cryptographic Hash* function in Cryptology has two properties:
+ *collision resistance*: There exits two inputs in the input space $x,y$, 
  they are not equal, $x != y$, but through the Hash function, their outputs 
  are same $upright(H)(x)=upright(H)(y)$. The real world is the input space, 
  it can be infinitely large, but the output space of Hash function is finite. 
  But Hash function can guarantee that it is extremely hard or nearly impossible 
  to find this kind of $x$ and $y$, so we say that Hash function is a kind of 
  *message digest* function.

  For a message $m$, then $upright(H)(m)$ can be described as the *digest* of 
  message $m$. So if message $m$ is changed by someone, then we can use the 
  $upright(H)(m)$ to detect it.

  md5 is a kind of Hash function, but we have found the way to produce the Hash 
  collision of md5 Hash function. And sometimes we want to avoid Hash collision 
  when we detect if two messages are different, we may append a nonce to 
  the original message:

  $ m || sans("nonce") --> upright(H)(m || sans("nonce")) $

+ *hiding*: Hash function can calculate the $upright(H)(m)$ from message $m$, 
  but we can't calculate $m$ from $upright(H)(m)$. Hash function is one-way. The 
  hiding property needs the input space of this Hash function large enough and uniform.

+ *puzzle friendly*: The Hash function used in Bitcoin has the third extra property. 
  The Bitcoin mining is the calculation procedure below:

  $ sans("block-header") || sans("nonce") --> upright(H)(sans("block-header") 
  || sans("nonce")) <= sans("target") $

  We need to find the $sans("nonce")$ that satisfies the condition above. And this 
  property "puzzle friendly" means that there is only one way to calculate the 
  $sans("nonce")$: *brute force*, and that's called the *proof of work*. Bitcoin is 
  *difficult to solve, but easy to verify*.

The Hash function Bitcoin used is *SHA-256* (Secure Hash Algorithm).

= 1.2 Signature

The account in Bitcoin doesn't need to be approved by some centralized banks, we only 
need to create the public key and private key. These terms come from the *asymmetric 
encryption algorithm*, we can draw two figures to distinguish symmetric encryption and 
asymmetric encryption:

#align(center)[
  #import fletcher.shapes: pill, parallelogram, diamond, hexagon, ellipse
  #figure(
    diagram(
      node(
        (0,0), 
        "Alice", 
        shape: parallelogram, 
        stroke: 0.5pt, 
        name: <alice>, 
        fill: teal.lighten(80%)
      ),
      node(
        (1.5,0), 
        "message", 
        shape: ellipse, 
        stroke: 0.5pt, 
        name: <message>, 
        fill: black.lighten(90%)
      ),
      node(
        (3,0), 
        "Bob", 
        shape: parallelogram, 
        stroke: 0.5pt, 
        name: <bob>, 
        fill: red.lighten(80%)
      ),

      edge(
        <alice.north>, 
        <message.north>, 
        "->", 
        $sans("encryption key")$, 
        bend: +40deg
      ),
      edge(
        <message.south>, 
        <bob.south>, 
        "->", 
        $sans("decryption key")$, 
        bend: -40deg
      ),
   ),
    caption: "Symmetric Encryption",
  )
]

In asymmetric encryption, the encryption key and decryption key are the same. 
If the key is stolen when it is transporting through the environment, 
the information won't be safe anymore. But the asymmetric encryption solves 
this problem:

#align(center)[
  #import fletcher.shapes: pill, parallelogram, diamond, hexagon, ellipse
  #figure(
    diagram(
      node(
        (0,0), 
        "Alice", 
        shape: parallelogram, 
        stroke: 0.5pt, 
        name: <alice>, 
        fill: teal.lighten(80%)
      ),
      node(
        (1.5,0), 
        "message", 
        shape: ellipse, 
        stroke: 0.5pt, 
        name: <message>, 
        fill: black.lighten(90%)
      ),
      node(
        (3,0), 
        "Bob", 
        shape: parallelogram, 
        stroke: 0.5pt, 
        name: <bob>, 
        fill: red.lighten(80%)
      ),

      edge(
        <alice.north>, 
        <message.north>, 
        "->", 
        $sans("public key") text("of Bob")$, 
        bend: +40deg
      ),
      edge(
        <message.south>, 
        <bob.south>, 
        "->", 
        $sans("private key") text("of Bob")$, 
        bend: -40deg
      ),
   ),
    caption: "Asymmetric Encryption",
  )
]

In Bitcoin transaction (simplified as *tx*), asymmetric encryption is used in 
*signature*. For example, Alice wants to give 10 bitcoins to Bob, she posts 
this transaction to the blockchain. This procedure needs her to use her private 
key to sign the transaction. The others on the blockchain can verify this 
using Alice's public key.

Creating the private and public key needs a good source of randomness, under 
this situation, creating the same private and public key with other's is 
impossible.

= 2 Data Structure

= 2.1 Hash Pointer and Blockchain

*Hash pointer* is a pointer to a memory block, but different from the traditional 
pointer, it stores the Hash value of the memory block. If the content of this 
memory block changes, the Hash value will also change.

#align(center)[
  #figure(
    diagram(
      node(
        (0,0), 
        shape: rect, 
        stroke: 0.5pt, 
        width: 30pt, 
        height: 30pt, 
        name: <memory>, 
        fill: teal.lighten(80%)
      ),
      node(
        (0.7,0), 
        "Hash value", 
        name: <hash-value>
      ),
      node(
        (1,-0.7), 
        "Hash pointer", 
        name: <hash-pointer>
      ),

      edge(<hash-pointer>, <memory.east>, "->"),
      edge(<hash-pointer>, <hash-value>, "->")
    ),
    caption: "Hash pointer"
  )
]

Blockchain is a *linked list using Hash pointer*, each node stores a prev pointer 
to its previous node. Here is an example of blockchain:

#align(center)[
  #figure(
    diagram(
      let max = 5,
      for i in range(1, max + 1) {
        node(
          (i - 1, 0), 
          "Hp", 
          shape: rect, 
          stroke: 0.5pt, 
          fill: red.lighten(90%), 
          name: label(str(i))
        )
        
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

Because every node on the blockchain stores the Hash pointer, whenever the content 
of some node $k$ changes, the Hash pointer to node $k$, which is stored by node 
$k+1$, will also change. Because node $k+1$ stores the Hash pointer to node $k$ and 
this Hash pointer has also changed. Continue this analysis procedure, and we will 
get this conclusion: *when the content of node $k$ changes*,

$ forall k + 1 <= i <= sans("most recent block"), 
  upright(H)(i) != upright(H)(i)_(sans("original")) $

So we can detect the Hash value (or Hash pointer) to the most recent block to detect 
every tiny change on the blockchain. This is called *tamper-evident log*.

= 2.2 Merkle Tree

*Merkle tree* is a binary tree using Hash pointer, each node stores two Hash pointers 
to the two leaf nodes. We can draw a figure to describe the Merkle tree:

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

      node(
        (0,0), 
        right_str, 
        name: <0>, 
        fill: yellow.lighten(80%)
      ),
      node(
        (+dis, height), 
        content_str, 
        name: <0-2>
      ),
      node(
        (-dis, height), 
        left_str, 
        name: <0-1>, 
        fill: yellow.lighten(80%)
      ),
      node(
        (-dis - gap, height * 2), 
        content_str, 
        name: <0-1-1>
      ),
      node(
        (-dis + gap, height * 2), 
        left_str, 
        name: <0-1-2>, 
        fill: yellow.lighten(80%)
      ),
      node(
        (+dis + gap, height * 2), 
        content_str, 
        name: <0-2-2>
      ),
      node(
        (+dis - gap, height * 2), 
        content_str, 
        name: <0-2-1>
      ),

      // data blocks

      node(
        (-dis - gap - data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-1>
      ),
      node(
        (-dis - gap + data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-2>
      ),
      node(
        (-dis + gap + data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: yellow.lighten(80%), 
        name: <data-3>
      ),
      node(
        (-dis + gap - data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-4>
      ),
      node(
        (+dis - gap - data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-5>
      ),
      node(
        (+dis - gap + data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-6>
      ),
      node(
        (+dis + gap - data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-7>
      ),
      node(
        (+dis + gap + data_gap, height * 3), 
        height: data_height, 
        width: data_width, 
        fill: teal.lighten(80%), 
        name: <data-8>
      ),

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

The blue blocks are called *data blocks*, the blocks that store two hash pointers 
are called *Hash pointer blocks*, and the root of this binary tree is called the 
*root Hash*. Every data block can store a transaction record. Every block in 
blockchain has two components: *block header* and *block body*. Block header stores 
the root Hash of a Merkle tree on this block, block header doesn't store the detailed 
information of transaction records.

There are two kinds of node:
- *Full node*: full node stores the detailed transaction records and the whole Merkle tree.
- *Light node*: light node only stores the Hash value of this light node on the Merkle tree.

The yellow block in data blocks is a light node, and when it wants to verify if a transaction 
record is written in it, it will request the full node to offer the Hash value of other branches 
(marked as #text("Hp", fill: red) in the figure above) and calculate the Hash value of each 
node in the path from this yellow block to the root. Finally, it will compare the calculated 
Hash value of root node and the stored Hash value of root node. This procedure is called 
*proof of membership*, and the time complexity is $O(log n)$, here $n$ is the quantity of 
data blocks.

= 3 Protocol

= 3.1 Decentralized Currency System

Consider that a central bank wants to issue some virtual currencies, but we can copy these 
virtual currencies to spend twice, and this is called *double spending attack*. To avoid 
this, central bank will append the information of signature to these virtual currencies, 
like this:

#align(center)[
  #import fletcher.shapes: pill, parallelogram, diamond, hexagon, ellipse
  #figure(
    diagram(
      node-stroke: 0.5pt,
      node(
        (0,0), 
        "$100 \n signed by A", 
        shape: parallelogram, 
        fill: teal.lighten(80%), 
        name: <A>
      ),
      node(
        (1.5,0), 
        "Central Bank", 
        shape: ellipse, 
        fill: black.lighten(90%), 
        name: <central>
      ),
      node(
        (3,0), 
        "$100 \n signed by B", 
        shape: parallelogram, 
        fill: red.lighten(80%), 
        name: <B>
      ),

      edge(
        <A.north>, 
        "-|>", 
        <central.north>, 
        label: "send to central bank",
        bend: +40deg
      ),
      edge(
        <central.south>, 
        "-|>", 
        <B.south>, 
        label: "approve by central bank", 
        bend: -40deg
      )
    ),
    caption: "Centralized Currency System"
  )
]

When A gives his currencies to B, this transaction will be approved by the central 
bank, and the signature changes from A to B. Every transaction should be approved 
by and transported through the central bank, that's called the *centralized 
currency system*.

Bitcoin comes from mining, and it's called *create coin*. A decentralized currency 
system needs Hash pointers to work:

#align(center)[
  #figure(
    diagram(
      node((0,0), "Create Coin"),
      node(
        (0, 0.4), 
        $arrow.long.r upright(A)(10)$, 
        name: <origin-A>
      ),
      node(
        enclose: ((0,0), <origin-A>), 
        stroke: 0.5pt, 
        fill: teal.lighten(80%), 
        name: <group-1>
      ),

      node((1.5,0), "A", name: <distribute-A-1>),
      node((2.4,-0.2), $upright(B)(5)$, name: <origin-B>),
      node((2.4,0.2), $upright(C)(5)$, name: <origin-C>),
      node((2, 0.6), "Signed by A", name: <sign-A-1>),
      node(
        enclose: (
          <distribute-A-1>, 
          <origin-B>, 
          <origin-C>, 
          <sign-A-1>
        ), 
        stroke: 0.5pt, 
        fill: teal.lighten(80%), 
        name: <group-2>
      ),

      node((3.8,0), "B", name: <distribute-B-1>),
      node((4.7,-0.2), $upright(C)(2)$, name: <distribute-C-1>),
      node((4.7,0.2), $upright(D)(3)$, name: <origin-D>),
      node((4.3, 0.6), "Signed by B", name: <sign-B-1>),
      node(
        enclose: (
          <distribute-B-1>, 
          <distribute-C-1>, 
          <origin-D>, 
          <sign-B-1>
        ), 
        stroke: 0.5pt, 
        fill: teal.lighten(80%), 
        name: <group-3>
      ),

      edge(<distribute-A-1>, "-|>", <origin-B.west>),
      edge(<distribute-A-1>, "-|>", <origin-C.west>),
      edge(<group-2>, "-|>", <group-1>),
      edge(
        <distribute-A-1>, 
        (1.5,1.2), 
        (0,1.2), 
        <origin-A>, 
        "-|>"
      ),

      edge(<distribute-B-1>, "-|>", <distribute-C-1.west>),
      edge(<distribute-B-1>, "-|>", <origin-D.west>),
      edge(<group-3>, "-|>", <group-2>),
      edge(
        <distribute-B-1>, 
        (3.8,-0.8), 
        (2.4,-0.8), 
        <origin-B>, 
        "-|>"
      ),
      edge(
        <distribute-C-1>, 
        (4.7,-0.8), 
        (5.3,-0.8), 
        (5.3,1.2), 
        (3.0, 1.2), 
        <origin-C>, 
        "-|>"
      )
    ),
    caption: "Decentralized Currency System"
  )
]

In 1.2 Signature we say that every person who wants to transfer his currencies to 
other needs to sign this transaction using his private key. This is to avoid the 
double spending attack. For *A*, a transaction from A to B, he needs two things:
- The *signature of A*, this is created by A's private key, others can verify it 
  using A's public key;
- The *address of B*, and it can be calculated by the Hash value of B's public key. 
  In blockchain world, one's address is equal to the bank account ID in real world. 
  Similar with the real world, bank doesn't have a way to search one's account ID, 
  bitcoin system also doesn't have a way to search one's address.

For *B*, a transaction from A to B, he needs just one thing:
- The *public key of A*, B needs to verify that this transaction is indeed from A. 
  And the public key of A can be obtained from this transaction automatically.

The first node is called *coinbase*, and this will provide the Hash value of A. 
We can consider a transaction as a model has *input* and *output*. For a transaction 
from A to B, the input includes the public key of A, and the output includes the 
signature of A and the address of B (equivalent to the Hash value of B's public key). 
If we can't go back to the coinbase from this transaction, then we know this 
transaction is malicious.

*
In blockchain, a block has two components:
- Block header (includes necessary information):
  - The version of bitcoin protocol;
  - The Hash pointer to the previous block header;
  - The root Hash value of Merkle tree in Block body;
  - Timestamp
  - The target of mining difficulty (see 1.1 Hash function);
  - The nonce of mining.
- Block body
*

= 3.2 Distributed Consensus

Actually, blockchain is a kind of *distributed system* (more accurately, 
*decentralized ledger*), it's a field of computer science (I haven't heard before). 
*Distributed consensus* is used in these distributed systems, such as *Paxos*. 
Now I am only need to learn the distributed consensus in Bitcoin, those algorithms 
are designed to decide on which node is malicious.

But, how to decide?

There is a blockchain architecture called #link("https://github.com/hyperledger/fabric")
[*hyperledger fabric*], this is a kind of *alliance chain*. It only allows some reliable 
company to vote on which node is malicious. But in Bitcoin, we doesn't use alliance chain, 
every node has voting rights. But when malicious nodes are more than normal nodes, 
malicious nodes can attack indiscriminately. This is called *sybil attack*.

#align(center)[
  #figure(
    diagram(
      node-shape: rect,
      node-stroke: 0.5pt,
      node-fill: red.lighten(80%),
      node((0,0), $space.en$, name: <1>),
      node((1,0), $space.en$, name: <2>),
      node((2,0), $upright(A) arrow.r upright(B)$, name: <3>),
      node((2,0.7), $upright(A) arrow.r upright(C)$, name: <4>),
      node((3,0), $space.en$, name: <5>),

      edge(<2>, "-|>", <1>),
      edge(<3>, "-|>", <2>),
      edge(<4.west>, "-|>", <2.south>),
      edge(<5>, "-|>", <3>)
    ),
    caption: "Longest PoW Chain"
  )
]

So to avoid this attack, Bitcoin doesn't use this method (In the bitcoin whitepaper, 
it's called *one-IP-address-one-vote*), it uses *PoW* (Proof-of-Work, or can be called 
*one-CPU-one-vote*). Different nodes have different computing power, the node who first 
calculates the nonce of this block has the right to write this block into blockchain. 
The majority decision is represented by the longest chain, which has the most PoW effort 
invested in it. The attacker node in figure 8 which is represented as 
$upright(A) arrow.r upright(C)$ transaction is double-spending, so it can't be verified.

The longest PoW chain works as follows:
*
1. New transactions are broadcast to all nodes;
2. Each node collects new transactions into a block;
3. Each node works on finding a difficult PoW for its block;
4. When a node finds a PoW, it broadcasts the block to all nodes;
5. Nodes accept the block only if all transactions in it are valid and not double-spending;
6. Nodes express their acceptance of the block by working on creating the next block in the 
  blockchain, using the hash of the accepted blocks as the previous hash.
*

If two nodes broadcast different versions of the next block simultaneously, some nodes may 
receive one or another first, In that case, they work on the first one they received, but 
save the other branch in case it becomes longer. This situation will be broken when the 
next PoW is found and one branch becomes longer; the nodes that are working on the other 
branch will then switch to the longer one. This branch is then called the *orphan branch*.

= 4 Implements

= 4.1 UTXO

In 3.1 decentralized currency system we introduce the structure of a transaction in bitcoin 
system. In bitcoin system, UTXO is the basic unit of transactions, and actually it's a kind 
of data structure that records the input and output. Consider that Alice wants to initiate a 
transaction with Bob:

#align(center)[
  #figure(
    diagram(
      let dis = 2.4,
      let gap = 0.4,
      let height = 0.6,

      let inner_corner = 3pt,
      let outer_corner = 5pt,

      node-stroke: 0.5pt,
      node((0,0), "coinbase tx", stroke: 0pt, name: <tx0-name>),
      node(
        (gap, height), 
        "Out", 
        shape: rect, 
        corner-radius: inner_corner, 
        name: <tx0-out>
      ),
      node(
        enclose: (<tx0-name>, <tx0-out>), 
        corner-radius: outer_corner, 
        name: <tx0>
      ),

      node((dis,0), "tx-1", stroke: 0pt, name: <tx1-name>),
      node(
        (dis - gap, height), 
        "In", 
        shape: rect, 
        corner-radius: inner_corner, 
        name: <tx1-in>
      ),
      node(
        (dis + gap, height), 
        "Out", 
        shape: rect, 
        corner-radius: inner_corner, 
        name: <tx1-out-1>
      ),
      node(
        (dis + gap, 2 * height), 
        "Out", 
        shape: rect, 
        corner-radius: inner_corner, 
        name: <tx1-out-2>
      ),
      node(
        enclose: (
          <tx1-name>, 
          <tx1-in>, 
          <tx1-out-1>, 
          <tx1-out-2>
        ), 
        corner-radius: outer_corner
      ),

      node((2 * dis - gap, height), "Bob", stroke: 0pt, name: <bob>),
      node((2 * dis - gap, 2 * height), "Alice", stroke: 0pt, name: <alice>),

      edge(<tx0-out>, "-|>", <tx1-in>, label: "6.25 BTC"),
      edge(<tx1-out-1.east>, "-|>", <bob>, label: "4 BTC"),
      edge(<tx1-out-2.east>, "-|>", <alice>, label: "2.25 BTC"),
    ),
    caption: "UTXO"
  )
]

Alice gets 6.25 BTC from coinbase transaction, and that's an UTXO which has no input, 
only output. Alice gives 4 BTC to Bob, according to the principle that UTXO needs 

$ sans("total inputs") = sans("total outputs") $

(Notice bitcoin system allows miner node to charge other nodes who haven't found the 
nonce of this block, and that's called *transaction fee*), this UTXO must also include 
Alice initiating a transaction with itself, whose output is 2.25 BTC.

Bitcoin system sets the time gap between two blocks generating to be *10 minutes*, and 
every 210_000 blocks the *block reward* halves:

$ (210000 times 10) / (60 times 24 times 365) approx 4 $

that's to say about every 4 years the block reward halves.

= 4.2 Mining Difficulty

Mining difficulty is inversely proportional to the target, we use constant value 
`difficulty_1_target` to represent the target when `difficulty` equals 1. We have

$ sans("difficulty")=sans("difficulty_1_target") / sans("target") $

Bitcoin system should keep the block release time stable (10 min), and so it should adjust 
the difficulty to suit the CPU power of the whole network. Bitcoin protocol dictates a 
time period (2016 blocks, about 14 days) for adjusting the difficulty. The adjustment method is

$ sans("target")_(sans("new"))=sans("target")_(sans("old")) times sans("actual time") / sans("expected time") $

For a miner, to calculate the nonce is so difficult that the expectation of earnings can 
be very low (even negative). So to raise the expectation of earnings, *pool managers* appear. 
They hire many mines to work together, and they will divide the block reward equally.

= 4.3 Script

The structure of a transaction may look like this:

```json
"result" : {
  "txid" : "921a...dd24",
  "hash" : "921a...dd24",
  "version" : 1,
  "size" : 226,
  "locktime" : 0,
  "vin" : [...],
  "vout" : [...],
  "blockhash" : "0000000000000000002c510d...5c0b",
  "confirmations" : 23,
  "time" : 15308446727,
  "blocktime" : 153084446727
}
```

`"vin"` is the inputs of a transaction, and it's an array like this:

```json
"vin" : [
  {
    "txid" : "c0cb...c57b",
    "vout" : 0,
    "scriptSig" : {
      "asm" : "3045...0018",
      "hex" : "4830...0018"
    },
  },
  ...
]
```

`"vout"` is the output of a transaction, and it's an array like this:

```json
"vout" : [
  {
    "value" : 0.22684000,
    "n" : 0,
    "scriptPubKey" : {
      "asm" : "DUP HASH160 628e...d743 EQUALVERIFY CHECKSIG",
      "hex" : "76a9...88ac",
      "reqSigs" : 1,
      "type" : "pubkeyhash",
      "addresses" : [
        "119z8LJkNXLrTv2QK5jqTncJCGGUEEfpQvSr"
      ]
    }
  }
  ...
]
```

The script contents in `"scriptSig"` and `"scriptPubKey"` are a stack-based language 
used in Bitcoin system. And later we will call `"scriptSig"` in `"vin"` as *input 
script*, and `"scriptPubKey"` in `"vout"` as *output script*. Consider there are 
two transactions $upright(A) arrow upright(B)$ and $upright(B) arrow upright(C)$, 
early versions of Bitcoin system stitch together the output script in $upright(B) 
arrow upright(C)$ and the input script in $upright(A) arrow upright(B)$ to check if 
the total script would fail. Now Bitcoin system will run the input script in 
$upright(B) arrow  upright(C)$ first, then run the output script in 
$upright(A) arrow upright(B)$, for the *safety consideration*.

- *P2PK (Pay to Public Key)* :

  The P2PK scripts look like this, they only use public key to verify a transaction:

  ```
  input script (B -> C):
    PUSHDATA(Sig)
  output script (A -> B):
    PUSHDATA(PubKey)
    CHECKSIG
  ```

  Notice the signature there is from transaction $upright(B) -> upright(C)$, which is B's 
  signature. And the public key here is from transaction $upright(A) -> upright(B)$, which 
  is B's public key. `CHECKSIG` here is to verify the signature.

- *P2PKH (Pay to Public Key Hash)* :

  Output script ($upright(A) -> upright(B)$) in the P2PKH doesn't give the public key of B, 
  but the hash value of public key. It may look like this:

  ```
  input script (B -> C):
    PUSHDATA(Sig)
    PUSHDATA(PubKey)
  output script (A -> B):
    DUP
    HASH160
    PUSHDATA(PubKeyHash)
    EQUALVERIFY
    CHECKSIG
  ```

  `DUP` here is to copy the top element in the stack and push to it (here is to copy the 
  `PubKey` element). `HASH160` is to pop the top element and then push its hash value to 
  the stack.

- *P2SH (Pay to Script Hash)* :

  Use #link("https://github.com/bitcoin/bips/blob/master/bip-0016/qa.mediawiki")[BIP-0016] 
  proposal, the script looks like:

  ```
  input script (B -> C):
    ...
    PUSHDATA(Sig)
    ...
    PUSHDATA(serialized redeemScript)
  output script (A -> B):
    HASH160
    PUSHDATA(redeemScriptHash)
    EQUAL
  ```

  Bitcoin will first check the redeem script using its hash value, and then deserialize the 
  serialized redeem script to execute it.