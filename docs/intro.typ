#title[Introduction]

#let version = toml("../typst.toml").package.version

Welcome to the documentation for Otter Docs #version.

Writing documentation is a lame task. It is even more boring and frustrating when you have to setup toolchains and
environments and debug for hours to make sure that they build correctly, only to find that the current tools cannot plot
your diagrams, or the PDF generation is missing fonts and takes hours to build. So here's Otter Docs. A simple tool that
has a single requirement: #link("https://github.com/typst/typst")[Typst].

Typst is good at generating PDFs. It also has experimental support for HTML files. Since #link(
  "https://github.com/typst/typst/pull/7964",
)[\#7964] Typst can export multiple files for a single project, which makes it ideal for stuff like documentation sites.

Otter Docs uses the bundle target. You can make a new project in Typst, set it to bundle export, and it would generate a
site for you. It's only a typst template, and you don't need to worry about setting up the toolchain – Typst is the only
tool required.

= An Unfinished Project

Otter Docs is a decent choice for organizing long, comprehensive documentation. But just like Typst, Otter Docs is an
unfinished project, and is (currently) not a serious tool. Specifically, it's missing these stuff:

- Search engine optimizations (SEO)
- HTML minification; useful for reducing the page size without losing content
- Proper footnote support

However, if you want pure Typst documentation, ease of use, and/or MathML formulae, you might want to give it a try. If
you want stability and extremely easy syntax, then maybe you should consider mdBook. If you have any issues, please feel
free to #link("https://github.com/wensimehrp/otter-docs/issues")[open a ticket on GitHub]. If you would like to
contribute, please #link("https://github.com/wensimehrp/otter-docs/pulls")[open a pull request].

= Installation

Because Otter Docs is a pure Typst framework, you do not need to install other tools. No Python, no shell scripts, only
Typst. However, there are some caveats. Otter Docs is not currently available on the Typst Universe, and it requires a
#link(
  "https://github.com/typst/typst/commit/de6f400976f9bf6ab8b923d13a068722959d0070",
)[very specific version of Typst]. You would, unfortunately, have to build the compiler yourself. If you are a Nix user,
you can use the `flake.nix` file in the repository to setup the environment.

Once Typst 0.15 releases and Otter Docs makes its way to the Universe, the installation process should just be a simple
one liner like ```typ #import "@preview/otter-docs:0.1.0": *```.

= Licensing

The source and the documentation are available under #link("https://www.apache.org/licenses/LICENSE-2.0")[Apache License
  v2.0].
