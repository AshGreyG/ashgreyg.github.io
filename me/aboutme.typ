#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

#show: book-page.with(title: "CLRS (0): Foundations")
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

= Grey (Yuhui) He

I am a second-year undergraduate in the #link("https://www.sps.tsinghua.edu.cn/spsen/")[School of Pharmaceutical Science] at THU (Tsinghua University). And I was also minor in Computer Science for a short time, though gave up due to the pressure and disappointment.

My personal interests include *Computer Graphics*, learning Maths and writing essays / notes / posts etc. (Definitely more in the future).

My social links:

- #link("https://github.com/AshGreyG")[Github], you can see my recent projects or codes here.
- #link("https://x.com/Huaier_AshGrey")[Twitter], you can see my social activities here (though is's boring).

= Contact

- My email is ashgrey [dot] huaier [at] gmail [dot] com.
- My WeChat ID is Huaier [dash] AshGrey.

\
This blog is under construction...
