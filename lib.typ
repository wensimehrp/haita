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

// https://github.com/typst/typst/issues/2196#issuecomment-1728135476
#let to-string(it) = {
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
  let new-tree = ()
  for it in tree {
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
      description: description,
      authors: authors,
      root: root,
      language: language,
      ..args,
    )
  }
}
