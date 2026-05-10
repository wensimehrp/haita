#let paged-renderer(c) = {
  c
}

#import "tree.typ": *

// Documents are separated by pages.
#let prose-classes = {
  for (level, font-size) in (
    h1: "text-3xl",
    h2: "text-2xl",
    h3: "text-xl",
  ) {
    let selector = "[&>" + level + "]:"
    ("font-bold", "mt-8", font-size).map(it => selector + it)
  }
  ("[&>p]:mt-4",)
}

#let document-page-tracker = state("document-page-tracker", (folder: (:)))
#let heading-tracker = state("heading-tracker", (:))

#let heading-body-to-id(h) = {
  let t = h.body.fields().text
  lower(t).replace(regex("\s+"), "-")
}

/// Renders the HTML
#let html-renderer(c, route, title, description, ..args) = {
  import "@local/typhoon:0.1.0": *
  let current-route = route
  let current-title = title
  // Tailwind setup
  show: tailwind-page

  // Page tracker setup
  document-page-tracker.update(it => {
    let subtree = (
      route.last(): (
        file: (title: title, description: description, content: c),
      ),
    )
    for step in route.rev().slice(1) {
      subtree = ((step): (folder: subtree))
    }
    merge-tree(it, (folder: subtree))
  })

  import html: *

  // Code block setups
  show raw.where(block: true): div.with(
    class: "relative mt-4 p-2 max-h-[70vh] overflow-auto bg-neutral-100 border border-neutral-300",
  )
  show raw.where(block: false): span.with(
    class: "bg-neutral-100",
  )

  // Page body
  div({
    // Side navigator
    input(class: "z-10 fixed peer md:hidden top-4 left-4 checked:translate-x-72 transition-transform", type: "checkbox")
    nav(
      class: "w-72 z-10 flex fixed left-0 top-0 h-full -translate-x-full shadow-sm md:shadow-none peer-checked:translate-x-0 md:translate-x-0 flex-col border-r border-neutral-300 bg-neutral-100 transition-transform",
      {
        img(
          class: "max-h-40 mx-auto my-5",
          src: "https://upload.wikimedia.org/wikipedia/commons/3/36/WLE_Austria_Logo_%28transparent%29.svg",
        )
        div(class: "border-t border-neutral-300 overflow-x-auto", context {
          let heading-tree = (folder: (:))
          for (path, headings) in heading-tracker.final() {
            let route = path.split("/")
            let subtree = (route.last(): (file: (headings: headings)))
            for step in route.rev().slice(1) {
              subtree = ((step): (folder: subtree))
            }
            heading-tree = merge-tree(heading-tree, (folder: subtree))
          }
          let document-tree = merge-tree(heading-tree, document-page-tracker.final())
          let render-document-tree(t, route) = {
            if "file" in t {
              let link-base = "/" + route.join("/")
              a(href: link-base, class: "block py-2 flex-1 font-bold", t.file.title)
              input(
                class: "p-2 mr-2 peer",
                type: "checkbox",
                checked: route == current-route,
                autofocus: route == current-route,
              )
              ol(
                class: "border-l border-t border-b border-neutral-300 bg-white col-span-2 hidden peer-checked:block",
                {
                  for heading in t.file.at(
                    "headings",
                    default: (),
                  ) {
                    li(a(
                      class: "px-3 py-1 block text-sm w-full hover:bg-neutral-100",
                      href: link-base + "#" + heading-body-to-id(heading),
                      heading.body,
                    ))
                  }
                },
              )
              return
            } else if "folder" in t {
              for (path, file-or-dir) in t.folder {
                let next = route + (path,)
                let r = render-document-tree.with(file-or-dir, next)
                if "folder" in file-or-dir {
                  r()
                } else {
                  li(class: "pl-2 w-full grid grid-cols-[1fr_auto] hover:bg-neutral-200", {
                    r()
                  })
                }
              }
            }
          }
          ul(render-document-tree(document-tree, ()))
        })
      },
    )

    // main body
    div(class: "p-8 max-w-4xl md:ml-72 " + prose-classes.join(" "), {
      header()[Something Documentation]
      h1(current-title)
      {
        show heading: heading => {
          if heading.depth == 1 {
            heading-tracker.update(it => {
              let route-str = route.join("/")
              if route-str not in it {
                it.insert(route-str, ())
              }
              it.at(route-str) += (heading,)
              it
            })
          }
          elem("h" + str(heading.depth + 1), heading.body, attrs: (id: heading-body-to-id(heading)))
        }
        c
      }
      // query into the future and display some stuff
      footer(
        class: "mt-4 py-8 grid grid-cols-[1fr_1fr] gap-4",
        context {
          let final = flatten-tree(document-page-tracker.final())
          let current-idx = final.position(((it, _)) => route == it)
          let link-classes = " border-1 border-neutral-300 p-4 hover:bg-neutral-100 hover:shadow-xs"
          if current-idx > 0 {
            let (route, info) = final.at(current-idx - 1)
            a(class: "col-start-1" + link-classes, href: "/" + route.join("/"), "« " + info.title)
          }
          if current-idx < final.len() - 1 {
            let (route, info) = final.at(current-idx + 1)
            a(class: "col-start-2 text-right" + link-classes, href: "/" + route.join("/"), info.title + " »")
          }
          p(class: "col-span-2 text-xs text-center")[
            Powered by #a(href: "https://github.com/wensimehrp/otter-docs")[Otter Docs]. Made in Vancouver with love.
          ]
        },
      )
    })
  })
}
