# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project Overview

This is a personal blog/notebook built with [Typst](https://typst.app/) using
the [shiroa](https://github.com/Myriad-Dreamin/shiroa) framework. The blog
contains notes on Computer Science and Mathematics topics, organized as chapters
in a book format.

**Key Technologies:**

- **Typst**: A markup language for academic writing (like LaTeX but modern)
- **shiroa**: A Typst web framework that provides responsive layouts, theming,
  and multi-target compilation (web/PDF)
- **fletcher**: For diagrams
- **circuiteria/zap**: For circuit diagrams (used in CO/DDCA posts)
- **ctheorems**: For theorem/definition/proof environments
- **lovelace**: For pseudocode listings

## Build Commands

### Local Development

```bash
# Build the site locally (requires shiroa installed)
shiroa build --font-path assets/fonts -w . -d ./dist .

# The build output goes to ./dist/
# index.html is the main entry point
```

### Installing shiroa (for local builds)

```bash
# Download font assets
mkdir -p assets/fonts/
curl -L https://github.com/Myriad-Dreamin/shiroa/releases/download/v0.1.2/font-assets.tar.gz | tar -xvz -C assets/fonts
curl -L https://use.fontawesome.com/releases/v6.4.2/fontawesome-free-6.4.2-desktop.zip -o fontawesome-free-6.4.2-desktop.zip
unzip fontawesome-free-6.4.2-desktop.zip
cp -r fontawesome-free-6.4.2-desktop/otfs/* assets/fonts/

# Download and install shiroa binary
curl -L https://github.com/Myriad-Dreamin/shiroa/releases/download/v0.3.1-rc3/shiroa-x86_64-unknown-linux-gnu.tar.gz | tar -xvz
chmod +x shiroa-x86_64-unknown-linux-gnu/shiroa
sudo cp shiroa-x86_64-unknown-linux-gnu/shiroa /usr/bin/shiroa
```

## Architecture

### Entry Points

- `book.typ` - Main book configuration that defines the table of contents and
  chapter structure
- `ebook.typ` - Entry point for PDF/ebook output using shiroa's ebook project

### Template System (`templates/`)

| File               | Purpose                                                                                |
| ------------------ | -------------------------------------------------------------------------------------- |
| `color.typ`        | Color scheme definitions (content, backgrounds, theorem/definition backgrounds, links) |
| `page.typ`         | Base page template (responsive layout, theme handling, font configuration)             |
| `ebook.typ`        | Wrapper for book compilation with chapter resolution                                   |
| `theorem.typ`      | Theorem, definition, and proof environments (wraps ctheorems)                          |
| `pseudocode.typ`   | Pseudocode listing style (wraps lovelace)                                              |
| `theme-style.toml` | Theme color schemes (light, rust, coal, navy, ayu)                                     |

### Content Structure (`post/`)

Posts are organized hierarchically:

```
post/
  CS/              # Computer Science notes
    Algorithm/     # Algorithms (CLRS-based, exercises)
    CO/            # Computer Organization (DDCA)
    Cryptography/  # Cryptography
    OS/            # Operating Systems
    PLT/           # Programming Language Theory (PFPL)
  Math/            # Mathematics notes
    Algebra/       # Linear Algebra, Abstract Algebra
    Analysis/      # Real Analysis
    Number-Theory/ # Elementary Number Theory
```

### Each Post File Structure

Every `.typ` post file follows this pattern:

```typst
// 1. Import dependencies
#import "@preview/fletcher:0.5.3" as fletcher: diagram, edge, node
#import "/book.typ": book-page
#import "/templates/pseudocode.typ": pseudocode
#import "/templates/theorem.typ": *
#import "/templates/color.typ" as color

// 2. Page setup
#show: book-page.with(title: "Post Title")
#show: thmrules.with(qed-symbol: $square$)

// 3. Style configuration (REQUIRED - keep this pattern)
#show: set text(fill: color.content, font: "C059", size: 12pt)
#show: set page(fill: color.background, numbering: "1")
#show link: it => { set text(fill: color.content-reference-link); it }
#show math.equation.where(block: true): set text(size: 14pt)

#let content-highlight(content) = box(
  content,
  outset: 0.1em,
  fill: rgb(color.content-highlight)
)

// 4. Title heading
#align(center, text(17pt)[= Post Title])

// 5. Content with sections, theorems, definitions, etc.
```

**Important**: Do NOT try to extract common styling into a shared file. Typst's
`#include` and `#import` mechanisms do not work reliably for show/set rules
across files. Each post must have its own inline style configuration.

### Book Table of Contents

The `book.typ` file defines the book structure using `#book-meta()`:

- Nested chapters using `#chapter(none)[...]` for folders/sections
- `#chapter("./path/to/file.typ")[Title]` for actual content files
- Files must be registered here to appear in the compiled book

### Adding a New Post

1. Create the `.typ` file in the appropriate `post/` subdirectory
2. Include the standard header imports and style configuration (shown above)
3. Add an entry to `book.typ` in the appropriate position in the nested chapter
   structure
4. The post will automatically appear in both web and PDF outputs

### Common Typst Patterns

**Theorems/Definitions:**

```typst
#theorem(number: "1.1")[Theorem statement...]
#definition(number: "1.1")[Definition...]
#proof[Proof content...]
```

**Pseudocode:**

```typst
#pseudocode([Algorithm Title], [
  + Step 1
  + *procedure* name(arg)
    + Substep
])
```

**Diagrams (fletcher):**

```typst
#import fletcher.shapes: *
#figure(diagram(node(...), edge(...)), caption: "...")
```

**Math inline:** `$x^2$` | **Math display:** `$ x^2 $`

## Important Constraints

1. **No shared styling file** - Each post must include its own style
   configuration (see "Each Post File Structure" above)

2. **Book registration required** - New posts must be added to `book.typ` or
   they won't appear in compilation

3. **Font requirements** - Uses "C059" font family; ensure this is available or
   the build may fail

4. **Shiroa version** - Currently using `v0.3.1-rc3` - check
   `.github/workflows/gh-pages.yaml` for current version
