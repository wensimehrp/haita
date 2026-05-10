#import "lib.typ": *

#let document-page = document-page.with(root: "/otter-docs/")

#document-page(route: "index.html", title: "Otter Docs Documentation", description: "Foo bar stuff")[
  = Welcome to Otter Docs

  Welcome to Otter Docs! Otter Docs is a pure Typst documentation framework.
]

#document-page(route: "getting-started.html", title: "Getting Started", description: "Get started with Otter Docs")[
  = Installation

  Directly fetch it from the Typst universe.

  = Example

  #raw(block: true, read("./doc.typ"), lang: "typst")
]

#document-page(route: "suka/this.html", title: "This", description: "Foo bar stuff")[
  = My Documentation

  = Important stuff

  = Even more emportant stuff

  #lorem(100)
]

#document-page(route: "suka/index.html", title: "that", description: "Aloha!")[
  = Foo
  = Bar
  = Baz
  = Fizz
  = Buzz
]
