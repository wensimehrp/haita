#!/usr/bin/env -S typst compile --features bundle,html --format bundle
#import "lib.typ": *
#import "@preview/cmarker:0.1.8"

#book(
  debug: true,
  title: "Otter Docs Documentation",
  canonical-url: "https://wensimehrp.github.io",
  root: "otter-docs",
  tree: (
    chapter("index", content: include "docs/intro.typ"),
    chapter("docs/tutorial"),
    chapter("docs/demo"),
    chapter("changelog", content: title[Changelog] + cmarker.render(read("CHANGELOG.md"))),
  ),
)
