#let chapter(
  path,
  content: auto,
  children: (),
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

#let normalize-tree(tree, root) = {
  let new-tree = ()
  for it in tree {
    if type(it) != dictionary or "kind" not in it {
      it = (
        kind: "other",
        content: it,
      )
    }
    if "path" in it {
      it.path = root + it.path
      it.insert("page-label", label("page:/" + it.path.join("/")))
    }
    if it.kind == "chapter" {
      let chapter-heading-state = state(it.path.join("/") + " chapter state", ())
      let chapter-title-state = state(it.path.join("/") + " title state", none)
      it.content = {
        show heading.where(level: 1): heading => {
          let heading-label = none
          if "label" in heading.fields() {
            heading-label = heading.label
            heading
          } else {
            heading-label = label(it.path.join("/") + ":" + heading.body.text)
            [#heading #heading-label]
          }
          chapter-heading-state.update(it => it + (heading-label,))
        }
        show title: title => {
          chapter-title-state.update(it => title.body)
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
    new-tree.push(it)
  }
  new-tree
}

#import "renderers.typ": html-renderer, paged-renderer

#let book(
  title: "",
  description: "",
  authors: (),
  root: (),
  language: "en",
  html-renderer: html-renderer,
  paged-renderer: paged-renderer,
  debug: false,
  tree: (),
  ..args,
) = context {
  let root = if type(root) == array { root } else { root.split("/").filter(it => it.len() > 0) }
  assert(type(authors) == array, message: "Authors must be an array of strings.")
  let normalized = normalize-tree(tree, root)
  // debug for testing the tree
  if debug { document(root.join("/") + "/__debug_tree.html", [#normalized]) }
  if target() in ("bundle", "paged") {
    paged-renderer(
      normalized,
      description: description,
      authors: authors,
      root: root,
      language: language,
      ..args,
    )
  }
  if target() in ("bundle",) {
    html-renderer(
      normalized,
      description: description,
      authors: authors,
      root: root,
      language: language,
      ..args,
    )
  }
}
