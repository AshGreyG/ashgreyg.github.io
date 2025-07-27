#import "@preview/ctheorems:1.1.3": *
#import "/templates/color.typ" as color

#let theorem = thmbox("theorem", "Theorem", fill: color.theorem-background)
#let definition = thmbox("definition", "Definition", fill: color.definition-background)
#let proof = thmproof("proof", "Proof")