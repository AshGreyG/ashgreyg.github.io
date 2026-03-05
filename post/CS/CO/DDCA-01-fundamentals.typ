#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/circuiteria:0.2.0"
#import "@preview/zap:0.4.0"
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "DDCA (1): Fundamentals")
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
#show figure.caption: set text(size: 9pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

#align(center, text(17pt)[
  = DDCA (1): Fundamentals
])

= 1 Number Systems

== 1.1 Basic Units

An $N$-digit decimal number represents one of $10^N$ possibilities: $0,1,...
10^N-1$. This is called the *range* of the number. And bits represents one of
two values, $0$ or $1$, and are joined together to form *binary number*. Each
column of a binary number has twice the weight of the previous column, so
binary numbers are base $2$. In binary, the column weights (from right to left)
are $1,2,4,8,...$. So $N$-bit binary number represents one of $2^N$
possibilities: $0,1,...,2^N-1$.

A group of four bits represents one of $2^4=16$ possibilities. Hence, it is
sometimes more convenient to work in *base 16*, called *hexadecimal*. Hexadecimal
numbers use the digits $0$ to $9$ along with the letters $A$ to $F$.

A group of eight bits is called a *byte*. The size of objects stored in computer
memories is customarily measured in bytes rather than bits. A group of four bits
is called a *nibble*. One hexadecimal digit stores one nibble and two hexadecimal
digits store one full byte.

Microprocessors handle data in chunks called *words*. The size of a word depends
on the architecture of the microprocessors. In modern computers, most
microprocessors use 64-bit words and older computers may still use 32-bit words.
Simpler microprocessors used in gadgets use 8- or 16-bit words.

Within a group of bits, the bit in the 1's column is called *least significant bits* (lsb),
and the bit at the end is called the *most significant bit* (msb).
Similarly within a word the bytes are identified as *least significant byte*
(LSB) and *most significant byte* (MSB).

The term *kilo* indicates $2^10 = 1024 ≈ 10^3$, so by handy confidence we call $2^10$ bytes
one *kilobyte*. The term *mega* indicates $2^20 = 1048576 ≈ 10^6$, and *giga*
indicates $2^30 = 1073741824 ≈ 10^9 $. And $1024$ bytes is called a *kilobyte*
(KB) or *kibibyte* (KiB), 1024 bits is called a *kilobit* (Kb) or *kibibit*
(Kib or Kibit)

== 1.2 Binary Operations

In addition if the sum of two digits is greater than what fits in a single digit,
we *carry* a $1$ into the next column. So in binary, we also perform this rule
and here is an example: $101_2 + 110_2 = 1011_2$.

Notice, digital systems usually operate on a *fixed* number of digits. Addition
is said to *overflow* if the result is too big to fit in the available digits.

+ Sign/Magnitude Numbers

  An $N$-bit sign/magnitude number uses the most significant bit as the sign and
  the remaining $N - 1$ bits as the magnitude (absolute value). A sign bit of $0$
  indicates positive and a sign bit of $1$ indicates negative. For instance,
  $5_(10) = 0101_2$ and $-5_(10) = 1101_2$. An $N$-bit sign/magnitude number spans
  the range $[-2^(N-1) + 1, 2^(N-1) - 1]$.

+ Two's Complement Numbers

  The most significant bit position has a weight of $-2^(N - 1)$ instead of
  $2^(N - 1)$. They overcome the shortcoming of sign/magnitude numbers: zero
  has a single representation. In two's complement representation ordinary
  $0$ is written as all zeros: $00...000_2$. Two's complement numbers of normal
  positive number is itself, for example $3_10 = 0011_2$ (in 4-bit). For normal
  negative number $n (n < 0)$:

  $ bold(0)1101...1010_2 stretch(→)^"complement" bold(1)0010...0101_2
    stretch(→)^(+ 1_2) bold(1)0010...0110_2 $

  For example, $(-3)_10 = 1101_2$ (in 4-bit). This process is called the
  *reversing the sign* method.

  Unlike sign/magnitude number system, the two's complement system has no separate
  $-0$. Zero is considered positive because its sign bit is $0$. It should be
  also clear that there is one more negative number than positive number because
  there is no $-0$. The most negative number $10...000_2 = -2^(N-1)$ is sometimes
  called *weird number*:

  $ bold(1)00...000_2 stretch(→)^"complement" bold(0)11...111_2
    stretch(→)^(+ 1_2) bold(1)00...000_2 $

  When a two's complement number is extended to more bits, the sign bit must be
  copied into the most significant bit positions. This process is called *sign
  extension*.

= 2 Logic Gates

== 2.1 Digital Abstraction

*Logic gates* are simple digital circuits that take one or more binary inputs
and produce a binary output. The relationship between the inputs and the output
can be described with a *truth table* or a *Boolean equations*.

+ *NOT* gate

  A NOT gate has one input $A$ and one output $Y$, its output $Y$ is the reverse
  of $A$. The Boolean equation can be represented as $Y = overline(A)$:

+ *Buffer*

  The other one-input logic gate is called a *buffer* and it simply copies the
  input to the output. From the logical point of view, a buffer is no different
  from a wire, but from the analog point of view, the buffer has the ability
  to quickly send its output to many gates. This triangle symbol indicates a
  buffer and a circle on the output is called a *bubble*:

+ *AND* gate

  The AND gate produces a $sans("true")$ output $Y$ if and only if both $A$ and
  $B$ are $sans("true")$. Otherwise the output is $sans("false")$. The Boolean
  equation of $Y = A ∩ B$

+ *OR* gate

  The OR gate produces a $sans("true")$ output if either $A$ or $B$ or both are
  $sans("true")$. The Boolean equation for an OR gate is written as $Y = A ∪ B$:

+ Other two-input gates

  The XOR gate is $sans("true")$ if $A$ or $B$ but not both are $sans("true")$.
  The XOR operation is indicated by $⊕$. The Boolean equation for a XOR gate
  is written as $T = A ⊕ B$. Other gates just reverse the output.

// Figure: Gates of not, buffer, and, or, xor, nand, nor, xnor
#align(center)[
  #let first-line-gates = ("not", "buf", "and", "or")
  #let second-line-gates = ("xor", "nand", "nor", "xnor")
  #stack(
    dir: ltr,
    spacing: 14pt,
    stack(
      dir: ttb,
      // Actually no matter we use `ltr` or `ttb`, the effect doesn't change

      spacing: 14pt,
      for gate-name in first-line-gates {
        figure(
          circuiteria.circuit({
            import circuiteria: *
            // type of variable 'gate-function-map' is 'dictionary'
            let gate-function-map = (
              "not": gates.gate-not,
              "buf": gates.gate-buf,
              "and": gates.gate-and,
              "or":  gates.gate-or,
            )
            let fn = gate-function-map.at(gate-name)
            fn(
              x: 0, y: 0, w: 1, h: 1,
              stroke: color.content + 0.6pt,
            )
          }),
          caption: [#upper(gate-name) Gate]
        )
      }
    ),
    stack(
      dir: ttb,
      spacing: 14pt,
      for gate-name in second-line-gates {
        figure(
          circuiteria.circuit({
            import circuiteria: *
            let gate-function-map = (
              "xor":  gates.gate-xor,
              "nand": gates.gate-nand,
              "nor":  gates.gate-nor,
              "xnor": gates.gate-xnor,
            )
            let fn = gate-function-map.at(gate-name)
            fn(
              x: 0, y: 0, w: 1, h: 1,
              stroke: color.content + 0.6pt,
            )
          }),
          caption: [#upper(gate-name) Gate]
        )
      }
    ),
  )
]

Many Boolean functions of three or more inputs exist. An $N$-input AND gate
produces a $sans("true")$ output when all $N$ inputs are $sans("true")$. An
$N$-input OR gate produces a $sans("true")$ output when at least one input
is $sans("true")$. An $N$-input XOR gate produces $sans("true")$ when odd of
inputs are $sans("true")$.

== 2.2 Beneath Digital Abstraction

Suppose the lowest voltage in the system is $0V$, also called *ground* or *GND*.
The highest voltage in the system comes from the power supply and is usually
called $V_("DD")$.

The mapping of a continuous variable onto a discrete binary variable is done by
defining *logic levels*. The first gate is called the *driver* and the second
gate is called the *receiver*, the output of the driver is connected to the input
of the receiver. The driver produces a LOW(0) output in the range of $0$ to
$V_("OL")$ or a HIGH(1) output in the range of $V_("OH")$ to $V_("DD")$.

If the receiver gets an input in the range of $0$ to $V_("IL")$ it will consider
the input to be LOW. If the receiver gets an input in the range of $V_"IH"$ to
$V_("DD")$, it will consider the input to be HIGH.

If for some reason such as noise or faulty components the receiver's input should
fall in the *forbidden zone* between $V_("IL")$ and $V_("IH")$, the behavior of
the gate is unpredictable.

$V_("OH")$, $V_("OL")$, $V_("IH")$ and $V_("IL")$ are called the output and
input high and low logic levels.

// Figure: Logic levels and noise margins
#align(center)[
  #figure(
    circuiteria.circuit({
      import circuiteria: *
      element.gate-not(
        x: 0, y: 0, w: 1, h: 1,
        id: "Driver",
        stroke: color.content + 0.6pt,
      )
      element.gate-not(
        x: (rel: 3, to: "Driver"), y: 0, w: 1, h: 1,
        id: "Receiver",
        stroke: color.content + 0.6pt,
      )
      wire.wire(
        "w1",
        ("Driver.west", (-1, 0.5)),
        color: color.content,
      )
      wire.wire(
        "w2",
        ("Driver-port-out", "Receiver-port-in0"),
        color: color.content,
      )
      wire.wire(
        "w3",
        ("Receiver-port-out", (5.5, 0.5)),
        color: color.content
      )
    }),
    caption: [Logic levels and noise margins]
  )
]

If the output of the driver is to be correctly interpreted at the input of
receiver we must choose $V_("OL") < V_("IL")$ and $V_("OH") > V_("IH")$. Thus
even if the output of the driver is contaminated by some noise the input of
the receiver will still detect the correct logic level. The *noise margin* (NM)
is the amount of noise that could be added to a worst-case output such that the
signal can still be interpreted as a valid input. It's an anti-interference
capability of circuit.

An ideal inverter would have an abrupt switching threshold at $V_("DD")
/ 2$. For $V(A) < V_("DD") / 2$, $V(Y) = V_("DD")$. For $V(A)
> V_("DD") / 2$, $V(Y) = 0$. In such case $V_("IH") = V_("IL") =
V_("DD") / 2$, $V_("OH") = V_("DD")$ and $V_("OL") = 0$.

But a real inverter changes more gradually between the extremes. The transition
between endpoints is smooth and may not be centered at exactly $V_("DD")
/ 2$. A reasonable place to choose the logic levels is where the slope of the
transfer characteristic $("d"V(Y)) / ("d"V(A)) = -1$. The two points
are called the *unity gain points*. Choosing logic levels at the unity gain
points usually maximizes the noise margins.

There are four major logic families:

+ TTL: Transistor-Transistor Logic
+ CMOS: Complementary Metal-Oxide-Semiconductor Logic
+ LVTTL: Low Voltage TTL Logic
+ LVCMOS: Low Voltage CMOS Logic

= 3 CMOS Transistors

== 3.1 Semiconductors

MOS transistors are built from silicon (Si). It's a group IV atom so it has
four electrons in its valence shell and forms bonds with four adjacent atoms,
resulting in a crystalline *lattice*. Silicon itself is a poor conductor because
all the electrons are tied up in covalent bonds. However it becomes a better
conductor when small amounts of impurities (called *dopant* atoms).

If a group V dopant such as arsenic (As) is added the dopant atoms have an extra
electron that is not involved in the bonds. The electron can easily move about
the lattice, leaving an ionized dopant atom $"As"^+$ behind. The electron carries
a negative charge so we call arsenic an *$n$-type dopant*.

If a group III dopant such as boron (B) is added, the dopant atoms are missing
an electron. This missing electron is called a *hole*. An electron from a
neighboring silicon atom may move over to fill the missing bond, forming an
ionized dopant atom $B^-$ and leaving a hole at the neighboring silicon atom.
The hole is a lack of negative charge so it acts like a positively charged
particle. Hence we call boron a *$p$-type dopant*.

The concentration of dopants, silicon is called a *semiconductor*.

== 3.2 Diodes

The junction between $p$-type and $n$-type silicon is called a *diode*. The
$p$-type region is called the *anode* and the $n$-type region is called the
*cathode*.

When the voltage on the anode rises above the voltage on the cathode, the diode
is *forward biased* and current flows through the diode to the cathode. But
when the anode voltage is lower than the voltage on the cathode, the diode is
*reverse biased* and no current flows.

#align(center)[
  #figure(
    zap.circuit({
      import zap: *
      set-style(zap: (
        stroke: color.content + 0.6pt,
        diode: (
          stroke: color.content + 0.6pt,
          fill: color.background
        ),
      ))
      diode("example", (0, 0), (3, 0))
    }),
    caption: [Symbols of diode]
  )
]

== 3.3 Capacitors

A *capacitor* consists of two conductors separated by an insulator. When a
voltage $V$ is applied to one of the conductors the conductor accumulates
electric *charge* $Q$ and the other conductor accumulates the opposite charge
$-Q$.

The *capacitance* $C$ of the capacitor is the ratio of charge to voltage:

$ C = Q / V $

and the capacitance is proportional to the size of the conductors and inversely
proportional to the distance between them:

$ C = (ϵ_0 ϵ_r S) / d $

#align(center)[
  #figure(
    zap.circuit({
      import zap: *
      set-style(zap: (
        stroke: color.content + 0.6pt,
        capacitor: (
          stroke: color.content + 0.6pt,
          fill: color.background
        ),
      ))
      capacitor("example", (0, 0), (3, 0))
    }),
    caption: [Symbols of capacitor]
  )
]

== 3.4 nMOS and pMOS Transistors

MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistors) is a sandwich of
several layers of conducting and insulating materials. And MOSFETs are built
on thin, flat *wafers* of silicon of about 15 to 30cm in diameter.

There are two flavors of MOSFETs: *nMOS* and *pMOS*. The $n$-type transistors
called nMOS have regions of $n$-type dopants adjacent to the gate called the
*source* and the *drain* and are built on a $p$-type semiconductor substrate.
The pMOS transistors are just the opposite.

#align(center)[
  #stack(
    dir: ltr,
    spacing: 4pt,
    figure(
      zap.circuit({
        import zap: *
        set-style(zap: (
          stroke: color.content + 0.6pt,
          nmos: (
            stroke: color.content + 0.6pt,
            fill: color.background
          ),
        ))
        nmos("example", (0, 0), (3, 0))
      }),
      caption: [Symbols of nMOS]
    ),
    figure(
      zap.circuit({
        import zap: *
        set-style(zap: (
          stroke: color.content + 0.6pt,
          pmos: (
            stroke: color.content + 0.6pt,
            fill: color.background
          ),
        ))
        pmos("example", (0, 0), (3, 0))
      }),
      caption: [Symbols of pMOS]
    ),
  )
]

The substrate of an nMOS transistor is normally tied to GND, the lowest voltage
in the system. When the gate is also at GND, the diodes between the source or
drain and the substrate are reverse biased. Hence there is no path for current
to flow between the source and drain, so the transistor is OFF. Consider the
gate is raised to $V_("DD")$, when a positive voltage is applied to the top plate
of a capacitor, it establishes an electric field that attracts positive charge
on the top plate and negative charge to the bottom plate.

*If the voltage is sufficiently large, so much negative charge is attracted to
the substrate and converts it to $n$-type*. This inverted region is called
*channel*. Now the transistor has a continuous path from the $n$-type source
through the $n$-type channel to the $n$-type drain, now electrons can flow from
source to drain and the transistor is ON.

pMOS is just the opposite.

Unfortunately MOSFETs are not perfect switches. In particular nMOS transistors
pass 0's well but pass 1's poorly. When the gate of an nMOS transistor is at
$V_("DD")$ the source will only swing between $0$ and $V_("DD") - V_t$ and
drain its drain ranges from $0$ to $V_("DD")$. Similarly pMOS transistors
pass 1's well but 0's poorly.
