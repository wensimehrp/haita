#title[Authoring]

This section will cover specific authoring details when using Haita. Please refer to #link(
  "https://typst.app/docs/tutorial/",
) and #link(
  "https://typst.app/docs/reference/syntax/",
) for Typst reference.

= Cross-references

You can reference different content using the following syntax:

#figure(caption: [Reference syntax])[```typ
// This attaches a `label` to the figure
#figure(..) <my-listing>

See @my-listing for an example.
See #link(<my-listing>)[This listing]
```] <reference-listing>

In addition, you can reference different pages using ```typc label("page:/path/to/page")```. See #link(
  "https://typst.app/docs/reference/foundations/label/",
) for additional information on labels. You can write the following to create a link to a different page:

```typ
#link(label("page:/path/to/page"))[See this page for help]
```

You can even create a reference to an HTML element:

```typ
#context if target() == "html" [
  #html.section[Foo bar baz] <foobar>
]
// somewhere else in the document
#context if target() == "html" [
  #link(<foobar>)[This section] explains.
]
```

You may reference a label located in one page from the same page or from a different page.

= Contextual Output And Embedding HTML

You can write different content for different targets, for example, embedding a link to a page via `iframe` in the HTML
target. In addition, Typst provides #link("https://typst.app/docs/reference/html/typed/")[a typed interface] for HTML
elements. Custom HTML elements may be embedded using ```typc html.elem()```

```typst
#context if target() == "html" {
  // target IS HTML. Write some HTML specific stuff
  html.elem(..)
  html.iframe(..)
  // or import the entire html interface
  import html: *
  div(..)
} else {
  // target IS NOT HTML. It is instead "paged", which is for PDF, PNG and SVG.
  // Write some PDF specific stuff
  curve(..)
}
```

Please always keep HTML specific content in the ```typc context if target() == "html" {..}``` block. HTML elems will not
work when using PDF export.

#context if target() == "html" [
  You are currently looking at the HTML target. The default theme "New Hamber" is inspired by #link(
    "https://documenter.juliadocs.org/stable/",
  )[Documenter.jl]'s "Documenter" theme, which is based on sphinx's #link(
    "https://github.com/readthedocs/sphinx_rtd_theme",
  )[sphinx_rtd_theme]. // You can also take a look at the #link(<doc.pdf>)[PDF document].

  #let src = ```typ
  #let youtube-video-player = html.iframe.with(
    class: "w-full aspect-video",
    title: "YouTube video player",
    allow: {
      "accelerometer; autoplay; clipboard-write; encrypted-media;"
      " gyroscope; picture-in-picture; web-share"
    },
    referrerpolicy: "strict-origin-when-cross-origin",
    allowfullscreen: true,
  )

  #figure(
    supplement: "Video",
    caption: [Watch something ★funky★],
    youtube-video-player(
      src: "https://www.youtube-nocookie.com/embed/rl7ppuXMfC8",
    ),
  )```
  #eval(src.text, mode: "markup")

  #figure(caption: [Source code for the video player above.], src)
] else [
  You are currently looking at the PDF target.
]
