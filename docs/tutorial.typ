#title[Tutorial]

Otter Docs uses Typst. If you are not familiar with Typst, you can first take a look at #link(
  "https://typst.app/docs/tutorial",
)[Typst's official tutorial] for info on how to write Typst.

= Authoring

If you've used a tool like #link("https://myriad-dreamin.github.io/shiroa/")[Shiroa] or mdBook, you might be familiar
with `book.typ` or `summary.md`. Both files contain metadata and instructions on how to organize the book. In Otter
Docs, all of that is concentrated to a single entrypoint -- the `book` function:

```typ
// Always remember to import the package
// NOTICE: OTTER DOCS IS NOT PUBLISHED TO THE TYPST UNIVERSE YET
// THIS LINE WOULD NOT WORK
#import "@preview/otter-docs:0.1.0": *

#book(
  // The routing root. Useful when you are deploying to a folder
  // under your root (e.g. when deployed to GitHub Pages)
  root: "otter-docs",
  // Your document's contents
  tree: (
    // You can add arbitrary content. The content would be displayed
    // in the summary, but would not generate html pages.
    [= Introduction],
    // This would create otter-docs/index.html. The content of the
    // chapter would be from `doc/intro.typ`
    chapter("index", content: include "doc/intro.typ"),
    // This would create otter-docs/doc/tutorial.html. In this case,
    // the content of the chapter is not explicitly stated, so it
    // look into ./doc/tutorial.typ in the current workspace.
    chapter("doc/tutorial"),
    // You can add separators, which would separate content in the summary.
    // Separators would not generate html pages.
    separator(),
    // Alternatively, if you would like to directly include the content
    // without creating a new file, you can write it like this:
    chapter("my-page", content: [
      #title[My Page]
      = Heading 1
      = Heading 2
      foo bar baz
    ]),
    // you can add more chapters afterwards.
  )
)
```

Each chapter should start with a #link("https://typst.app/docs/reference/model/title/")[`title`]. The title of the page
would also be displayed in the summary. Do not start your document with a level 1 heading that looks like this:
```typst = Heading```. Instead, write this:

```typ
#title[My amazing document]

= Heading 1

Over seas from coast to coast

= Heading 2

To find a place I love the most
```

The rest of your document is just normal Typst content. You could apply show rules or use functions, just like writing a
normal Typst document.

== Contextual Output

You can write different content for different targets, for example, embedding a link to a page via `iframe` in the HTML
target.

```typst
#context if target() == "html" {
  // target IS HTML. Write some HTML specific stuff
} else {
  // target IS NOT HTML. It is instead "paged", which is for PDF, PNG and SVG.
  // Write some PDF specific stuff
}
```

#context if target() == "html" [
  You are currently looking at the HTML target. The default theme "New Hamber" is inspired by #link(
    "https://documenter.juliadocs.org/stable/",
  )[Documenter.jl]'s "Documenter" theme, which is based on sphinx's #link(
    "https://github.com/readthedocs/sphinx_rtd_theme",
  )[sphinx_rtd_theme]. // You can also take a look at the #link(<doc.pdf>)[PDF document].

  #let youtube-video-player = html.iframe.with(
    class: "w-full aspect-video",
    title: "YouTube video player",
    allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
    referrerpolicy: "strict-origin-when-cross-origin",
    allowfullscreen: true,
  )

  #figure(
    caption: [Watch something ★funky★],
    youtube-video-player(
      src: "https://www.youtube-nocookie.com/embed/rl7ppuXMfC8",
    ),
  )
] else [
  You are currently looking at the PDF target.
]


= Compiling (CLI)

You can compile the document using the following arguments in your command line. Remember to replace `<input-file>` with
your actual filename. See `typst compile --help` for a list of available arguments.

```console
$ typst compile --features bundle,html <input-file> --format bundle ./dist
```

For the example provided, it will create the documentation in the `./dist` folder. Additionally, you can change
`compile` to `watch` and add the `--open` flag at the end to preview your document in real time. You can edit your .typ
source files, and any edits would be reflected immediately.

= Compiling (`typst.app`)

_The `typst.app` web app currently does not support the bundle target and MathML exports. This section would be
completed once the web app adds support for the bundle target._

= Architecture

The documentation system has two parts: the organizer, which is the #link(<otter-docs-book>)[`book` function], and the
renderer.

The `book` function would organize the content into a tree, and that tree is then fed into the renderer. The renderer
would take a tree, inspect it, then generate pages based on that tree. This means that writing your own renderer is
trivial. You can swap to a different renderer at any time.
