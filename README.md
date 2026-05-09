# Otter Docs

Documentation in pure Typst. No external tools required. Typst and Typst
only.[^1]

This project requires the `bundle` target, so make sure that you have the latest
version installed. You can compile the project as follows:

```console
$ typst c <input> --features bundle,html -f bundle
```

If you are using Nix and you've enabled flakes, you can use `nix develop` to
enter a devshell that comes with a version of Typst that supports the bundle
target.

[^1]: You may want to use an HTML minification tool after exporting the HTML
files.
