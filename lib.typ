#let _split-route(route) = {
  route.split(regex("/+")).filter(it => it.len() != 0)
}
#import "renderers.typ"

#let document-page(
  c,
  route: auto,
  title: none,
  description: none,
  ..args,
  root: "/",
  html-renderer: renderers.html-renderer,
  paged-renderer: renderers.paged-renderer,
) = context {
  assert(
    type(title) == str,
    message: "You must have a title and it must be a string",
  )
  assert(
    type(description) == str,
    message: "You must have a piece of description and it must be a string",
  )
  let route = _split-route(root + route)
  if target() == "bundle" {
    document(
      route.join("/"),
      title: title,
      description: description,
      ..args,
      html-renderer(c, route, title, description, args),
    )
  } else {
    paged-renderer(c)
  }
}
