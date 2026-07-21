# Haita Changelog

This is the change log for [Haita](https://github.com/wensimehrp/haita),
a pure Typst documentation framework.

# 0.3.0 (Jul. 21, 2026)

_There are no user-facing changes in this release._

# 0.3.0-rc1 (Jul. 19. 2026)

## Added
- Pagefind search integration, including placement, styling, and behaviour improvements
  - No-JS banner with informational messaging when JavaScript is unavailable
- Code block line counts and a copy-to-clipboard button
- Vendored fonts.
  - Used Lato for main content, Lete Sans Math for math, and Roboto Mono for monospaced text.
- Basic accessibility links for TOC and main content
- Extended documentation

## Changed
- Figure elements now centered
- Sidebar styles tweaked
- On-page TOC moved to right side of the page.
- Used relative CSS paths

## Removed
- Google Fonts API dependency for _New Hamber_
- `separator` element, in favour of `std.divider` (**breaking change**)

## Fixed
- Footnote color
- Pagefind nav box shrinking at small window heights
- Main TOC custom content styling

# 0.2.1 (Jul. 10, 2026)
- Improved the style of the handle for opening the navigation sidebar.

# 0.2.0 (Jul. 6, 2026)
- Changed name from `otter-docs` to `haita`.

# 0.1.0 (Jul. 3, 2026)
- _New Hamber_ HTML renderer
- Basic documentation features
- Typst template
