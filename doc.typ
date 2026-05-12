#import "lib.typ": *
#import "@preview/cmarker:0.1.8"

#book(title: "Otter Docs Documentation", root: "otter-docs", tree: (
  chapter("index", content: include "doc/intro.typ"),
  chapter("doc/tutorial"),
  chapter("changelog", content: title[Changelog] + cmarker.render(read("CHANGELOG.md"))),
))
