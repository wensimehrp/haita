# Otter Docs

Here's Otter Docs. A simple tool that
has a single requirement: [Typst](https://github.com/typst/typst). Here are some features:

- Pure Typst workflow
- Features inherited from Typst:
  - Simple yet expressive Typst syntax helping you focussing on your content
  - Native syntax highlighting
  - Native MathML output
  - Fast compliation
  - Native support for `watch` and `serve`
  - PDF and HTML generation from the same source (
      PDF generation is currently suspended. See <https://github.com/typst/typst/issues/8309> for details.
    )
  - HTML minification (
      HTML minification is currently internal to Typst. See <https://github.com/typst/typst/issues/5512> for
      details.
    )
- No client side JS by default, including when using Math.
- Good SEO
- Semantic output, and
- Minimal setup

## Example

![](./demo.png)

(See [doc.typ](./doc.typ) for a more comprehensive example)

(See <https://github.com/wensimehrp/otter-docs> for an online demo)

`main.typ`:

```typst
#!/usr/bin/env -S typst compile --features bundle,html --format bundle
// You MUST clone the repository since Otter Docs is not available in the Typst universe
#import "lib.typ": *
// Optional markdown support
#import "@preview/cmarker:0.1.8"

#book(
  title: "My docs",
  canonical-url: "https://example.com",
  tree: (
    chapter("index"), // this would include content from `intro.typ`
    [= User Guide],   // A heading in the summary
    chapter("install"), // this would include content from `install.typ`
    // Use the `include` syntax if you want to manually specify the filename
    chapter("tutorial", content: include "docs/tutorial.typ", children: (
      // Set children chapters here
      chapter("integration"),
      chapter("custom-renderer"),
      chapter("continuous-integration", content: [
        // Directly write the content if you don't want to make a new file
        #title[CI]
        Foo bar baz fizz buzz #lorem(100)
      ]),
    )),
    separator(), // a separator in the summary
    chapter("changelog",
      content: title[Changelog]
        + cmarker.render(
          read("CHANGELOG.md"),
        ),
    ),
  ),
)
```

`index.typ`: 

```typst
// Always start your page with a title
#title[My title]

// and place your content afterwards
```

You can make a new project in Typst using Otter Docs, set it to [bundle export](https://github.com/typst/typst/pull/7964),
and Otter Docs would generate a site for you. You don't need to worry about setting up the toolchain – Typst
is the only tool required.

## An Unfinished Project

Otter Docs is a decent choice for organizing long, comprehensive documentation. But just like Typst, Otter Docs is an
unfinished project, and is (currently) not a serious tool. Specifically, it's missing these features:

- Internationalization support
- Built-in search functions

However, if you want pure Typst documentation, ease of use, and/or MathML formulae, you might want to give it a try. If
you want stability and extremely easy syntax, then maybe you should consider mdBook. If you have any issues, please feel
free to [open a ticket on GitHub](https://github.com/wensimehrp/otter-docs/issues). If you would like to
contribute, please [open a pull request](https://github.com/wensimehrp/otter-docs/pulls).

## Installation

Because Otter Docs is a pure Typst framework, you do not need to install other tools. No Python, no shell scripts, only
Typst. However, there are some caveats. Otter Docs is not currently available on the Typst Universe, and it requires a
very specific version of Typst. You would, unfortunately, have to use a development version of the compiler. The best
way is to build the compiler yourself. If you are a Nix user, you can use the `flake.nix` file in the repository to
set up the environment. If you don't want to build it yourself, you can also download the binary at
<https://github.com/typst-community/dev-builds>

Once Typst 0.15 releases and Otter Docs makes its way to the Universe, the installation process should just be a simple
one liner like `#import "@preview/otter-docs:0.1.0": *`.

## Licensing

The source and the documentation are available under [Apache License
  v2.0](https://www.apache.org/licenses/LICENSE-2.0).
