#let merge-tree(base, patch) = {
  if "file" in base and "file" in patch {
    let merged-attrs = base.file + patch.file
    return (file: merged-attrs)
  }
  let result = base
  for (key, value) in patch {
    if key in base {
      result.insert(key, merge-tree(base.at(key), value))
    } else {
      result.insert(key, value)
    }
  }
  return result
}

#let flatten-tree(tree, prefix: ()) = {
  if "file" in tree {
    return ((prefix, tree.file),)
  }
  let entries = ()
  for (key, val) in tree.folder {
    let path = (prefix + (key,))
    entries += flatten-tree(val, prefix: path)
  }
  return entries
}

#let get-by-path(tree, path) = {
  if path.len() == 0 {
    if "file" in tree {
      return tree.file
    }
    return tree.folder
  }
  let key = path.first()
  if "folder" in tree and key in tree.folder {
    return get-by-path(tree.folder.at(key), path.slice(1))
  }
  panic("Path not found: " + repr(path))
}
