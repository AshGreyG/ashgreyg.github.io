#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (2): Data Structure")
#show: thmrules.with(qed-symbol: $square$)

#show: set text(fill: color.content)
#set page(fill: color.background)

#align(center, text(17pt)[
  = CLRS (2): Data Structure
])

= 1 Heap

= 1.1 Definition of Heap

The *binary heap* data structure is an array object that we can view as a
nearly complete binary tree. Each node of the tree corresponds to an element
of the array. The tree is completed filled on all levels except the lowest,
which is filled from the left up to a point.

An array $upright("A")$ that represents a heap is an object with two attributes:
$upright("A")."length"$ gives the number of elements in the array, and $upright("A")
."heap-size"$, which represents how many elements in the heap are stored within
array $upright("A")$. 

Although $upright("A")[1..upright("A")."length"-1]$ may contain numbers, only the elements 
in $upright("A") [1..upright("A")."heap-size"-1]$, where
$0≤upright("A")."heap-size"≤upright("A")."length"$, are valid elements of the heap. The 
root of the tree is $upright("A")[0]$.

#align(center)[
  #import fletcher.shapes: *
  #figure(
    diagram(
      let max-heap = (16, 14, 10, 8, 7, 9, 3, 2, 4, 1),
      let max-heap-pos = max-heap.map((value) => (value: value, x: 0, y: 0)),
      let gap-y = 0.6,
      let gap-x = 1.6,
      let index = 0,
      let stack = (0, ),
      while stack.len() != 0 {
        let i = stack.pop();
        if 2 * i + 2 <= max-heap.len() - 1 {
          stack.push(2 * i + 2);
          // Right child exists.
        }
        if 2 * i + 1 <= max-heap.len() - 1 {
          stack.push(2 * i + 1);
          // Left child exists.
        }
        if calc.even(i) and i != 0 {
          let parent = calc.floor((i - 1) / 2);
          let level = calc.floor(calc.log(int(i) + 1, base: 2));

          max-heap-pos.at(i).x = max-heap-pos.at(parent).x + gap-x / level;
          max-heap-pos.at(i).y = level * gap-y;
        }
        if calc.odd(i) and i != 0 {
          let parent = calc.floor((i - 1) / 2);
          let level = calc.floor(calc.log(int(i) + 1, base: 2));

          max-heap-pos.at(i).x = max-heap-pos.at(parent).x - gap-x / level;
          max-heap-pos.at(i).y = level * gap-y;
        }
        node(
          (max-heap-pos.at(i).x, max-heap-pos.at(i).y),
          str(max-heap.at(i)),
          name: label(str(i)),
          shape: "circle",
          stroke: 0.5pt + color.content,
          fill: color.definition-background
        )
        if i != 0 {
          edge(label(str(calc.floor((i - 1) / 2))), label(str(i)), "-")
        }
      }
    ),
    caption: "A max-heap viewed as binary tree"
  )
]

The core of heap is that in its array representation, its elements are continuous,
and we can calculate the parent, left child and right child index of a specified
node:

#pseudocode(
  [Algorithm 1: Position methods of heap],
  [
    + ▷ notice that here $i$ is 0-based.
    + *procedure* #smallcaps("Parent") *return* $display(⌊ (i - 1) / 2 ⌋)$
    + *procedure* #smallcaps("Left-Child") *return* $2i + 1$
    + *procedure* #smallcaps("Right-Child") *return* $2i + 2$
  ]
)

There are two kinds of binary heaps: *max-heap* and *min-heap*. In both kinds, the
values in the nodes satisfy a *heap property*.
+ In a max-heap, the max-heap property is that for every node $i$ other than the root:
  $ upright("A")[sans("Parent")(i)] ≥ upright("A")[i] $
+ In a min-heap, the min-heap property is that for every node $i$ other than the root:
  $ upright("A")[sans("Parent")(i)] ≤ upright("A")[i] $

For the heapsort algorithm, we use max-heap. Min-heap commonly implement priority queues.
Viewing a heap as a tree, we define the *height* of a node in a heap to be the number of
edges on the longest simple downward path from the node to a leaf, and we define the 
height of the heap to be the height of its root. Its height is $Θ(lg n)$.

= 1.2 Maintaining the Heap Property

