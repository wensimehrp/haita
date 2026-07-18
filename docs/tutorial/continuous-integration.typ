#title[Continuous Integration]

There are two separate steps in continuous integration. The first step is building your book, and the second is
deploying your book.

= GitHub Actions and Pages

Use the following CI file:

#raw(lang: "yaml", read("../../.github/workflows/docs.yml"), block: true)
