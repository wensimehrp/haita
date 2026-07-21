default:
    just --list

# build the site
build:
    ./dist.typ

# index the site
index: build
    pagefind --site ./dist --output-subdir haita/pagefind

# watch build output
watch:
    typst watch --features bundle,html --format bundle ./dist.typ ./dist --pretty

# build the readme using pandoc
build-readme:
    nix develop .#prepareRelease --command pandoc ./readme.typ -o README.md
