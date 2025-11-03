#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "OS Concepts (1): Introduction")
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
  = OS Concepts (1): Introduction
])

= 1 The Function of OS <function-of-os>

A computer system can be divided roughly into four components: the *hardware*,
the *operating system*, the *application programs*, and a *user*. From the
computer's point of view, the operating system is the program most intimately
involved with the hardware. So in this context, we can view an operating system
as a *resource allocator*.

The operating system is the one program running at all times on the computer,
usually called the *kernel*. Along with the kernel, there are two other types of
programs: *system programs*, which are associated with the operating system but
are not necessarily part of the kernel, and application programs, which included
all programs not associated with the operation of the system.

= 2 Computer System Organization <computer-system-organization>

A modern general-purpose operating system consists of one or more GPUs and a
number of device controllers connected through a common *bus* that provides access
between components and shared memory.

Typically, operating system have a *device driver* for each device controller.
This device driver understands the device controller and provides the rest of
the operating system with a uniform interface to the device.

= 2.1 Interrupts

Hardware may trigger an interrupt at any time by sending a signal to the CPU,
usually by way of the *system bus*. The system bus is the main communications
path between the major components. When the CPU is interrupted, it stops what
it is doing and immediately transfers execution to a fixed location. The fixed
location usually contains the starting address where the service routine for the
interrupt is located.
