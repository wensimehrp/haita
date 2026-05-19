#!/usr/bin/env -S typst compile --features bundle,html --format bundle
#import "lib.typ": *
#import "@preview/cmarker:0.1.8"

#book(
  debug: true,
  title: "Otter Docs Documentation",
  canonical-url: "https://wensimehrp.github.io",
  root: "otter-docs",
  html-renderer: new-hamber.html-renderer.with(
    summary-image-renderer: new-hamber.summary-image-renderer.with(
      "Otter Docs",
      "https://wensimehrp.github.io",
      bottom-content: [
        Otter Docs is a pure Typst documentation framework
      ],
    ),
  ),
  tree: (
    chapter("index", content: include "docs/intro.typ"),
    [= User Guide],
    chapter("installation", content: include "docs/installation.typ"),
    chapter("tutorial", content: include "docs/tutorial.typ", children: (
      chapter("integration", content: include "docs/integration.typ"),
      chapter("custom-renderer", content: include "docs/custom-renderer.typ"),
      chapter("continuous-integration", content: include "docs/ci.typ"),
    )),
    separator(),
    chapter("references", content: include "docs/references.typ"),
    chapter("demo", content: include "docs/demo.typ", children: (
      chapter("demo-code", content: include "docs/demo-code.typ"),
    )),
    chapter(
      "changelog",
      content: title[Changelog]
        + cmarker.render(
          label-prefix: "changelog-",
          read("CHANGELOG.md"),
        ),
    ),
  ),
)
