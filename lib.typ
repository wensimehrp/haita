/// This function defines a chapter in the output
/// ```example
/// #chapter("doc/lib.typ")
/// ```
/// -> chapter
#let chapter(
  /// The path to the chapter. When `content` is left blank
  /// the function would automatically look into the current directory
  /// and fetch the content if there is a file at the path ending in `.typ`
  /// -> str
  path,
  /// The content of the chapter.
  /// -> auto | content
  content: auto,
  /// Subchapters
  /// -> any | chapter
  children: (),
  /// Whether if this chapter is numbered
  /// -> bool
  numbered: true,
  /// Extra arguments passed to the renderer
  /// -> any
  ..args,
) = {
  let path = if type(path) == array { path } else { path.split("/").filter(it => it.len() > 0) }
  (
    kind: "chapter",
    path: path,
    content: if content == auto {
      include path.join("/") + ".typ"
    } else {
      content
    },
    children: children,
    ..args.named(),
  )
}

/// Creates a separator in the summary.
/// -> summary-item
#let separator() = (kind: "separator")

// https://github.com/typst/typst/issues/2196#issuecomment-1728135476
#let to-string(
  it,
) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let normalize-tree(tree, root) = {
  assert(type(tree) == array, message: "The tree argument must be an array. Maybe you forgot a comma?")
  tree.map(it => {
    if type(it) != dictionary or "kind" not in it {
      it = (
        kind: "other",
        content: it,
      )
    }
    let path-str = none
    if "path" in it {
      it.path = root + it.path
      path-str = it.path.join("/")
      it.insert("page-label", label("page:/" + path-str))
    }
    if it.kind == "chapter" {
      let chapter-heading-state = state(path-str + " chapter state", ())
      let chapter-title-state = state(path-str + " title state", none)
      it.content = {
        show heading.where(level: 1, outlined: true): head => {
          if "label" in head.fields() {
            chapter-heading-state.update(arr => arr + (head.label,))
            head
          } else {
            let key = lower(path-str + to-string(head).replace(" ", "-"))
            [#heading(head.body) #label(key)]
          }
        }
        show title: title => {
          chapter-title-state.update(state => title.body)
          title
        }
        it.content
      }
      it.insert("title", chapter-title-state.final())
      it.insert("headings", chapter-heading-state.final())
    }
    if "children" in it {
      it = (..it, children: normalize-tree(it.children, root))
    }
    it
  })
}

#import "new-hamber.typ"

/// The entrypoint of the entire documentation.
/// -> content
#let book(
  /// The title of the documentation.
  /// -> str
  title: "",
  /// The description of the documentation.
  /// -> str
  description: "",
  /// The canonical URL of the documentation, e.g. the site's domain when you
  /// deploy the documentation to a website. Examples include `<username>.github.io`
  /// for GitHub Pages and `<project name>.pages.dev` for Cloudflare Pages.
  /// -> str
  canonical-url: "",
  /// Whether or not to render the summary images. Summary images are displayed
  /// when pasting pages' link in various social media, such as Telegram, Discord,
  /// and X.
  /// -> bool
  render-summary-image: true,
  /// The authors of the documentation. It should be an array of strings.
  /// -> array
  authors: (),
  /// The root of the site. Set this when you are not deploying the documentation
  /// to the root of your website, instead you're deploying it to a subfolder.
  /// E.g., when deploying to GitHub Pages.
  /// -> str | array
  root: (),
  /// The language of the documentation
  /// -> str
  language: "en",
  /// Which HTML renderer to use. By default it uses _New Hamber_'s html renderer.
  /// -> function
  html-renderer: new-hamber.html-renderer,
  /// Which paged (PDF, PNG, SVG) renderer to use. By default it uses
  /// _New Hamber_'s paged renderer.
  /// -> function
  paged-renderer: new-hamber.paged-renderer,
  /// Whether to enable the debug mode or not.
  /// -> bool
  debug: false,
  /// The content of your documentation.
  /// -> array
  tree: (),
  /// Extra arguments that are passed to the renderers.
  /// -> any
  ..args,
) = context {
  let root = if type(root) == array { root } else { root.split("/").filter(it => it.len() > 0) }
  assert(type(authors) == array, message: "Authors must be an array of strings.")
  let normalized = normalize-tree(tree, root)
  // debug for testing the tree
  if debug { document(root.join("/") + "/__debug_tree.html", [#normalized]) }
  if target() in ("paged",) {
    panic("Paged export is suspended until https://github.com/typst/typst/pull/8250 is merged")
    // paged-renderer(
    //   normalized,
    //   description: description,
    //   authors: authors,
    //   root: root,
    //   language: language,
    //   ..args,
    // )
  }
  if target() in ("bundle",) {
    html-renderer(
      normalized,
      title: title,
      description: description,
      canonical-url: canonical-url,
      render-summary-image: render-summary-image,
      authors: authors,
      root: root,
      language: language,
      ..args,
    )
  }
}
