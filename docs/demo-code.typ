#title[Code Demo]

Typst provides syntax highlighting for code blocks. See #link("https://typst.app/docs/reference/text/raw/") for details
including how to change the scheme and how to add highlighting for custom languages.

= Rust

```rust
use typst_wasm_protocol::wasm_export;

/// Tell me something and I'll repeat that
#[wasm_export]
pub fn echo(data: &[u8]) -> Result<Vec<u8>, String> {
    unsafe {
        let a: &str = Ok("I'm doing nothing...").unwrap_unchecked();
    }
    Err("unimplemented, do not call...".to_string())
}
```

= C++

```cpp
#include <iostream>

int foo(int *a, int *b);

int main(int argc, char **argv) {
    int a = 21, b = 21;
    std::cout << "Hi!\nThe answer is " << foo(&a, &b) << "\n";
    return 0;
}

[[nodiscard]] int foo(int *a, int *b) {
    return *a + *b;
}
```

= Python

```py
with open("file.txt", "w") as f:
    print("Hello, world!", file=f)
print("error!", file=f)
```

= Typst Math

#let m = ```typm
L = integral^b_a sqrt(1 + ((dif y) / (dif x))^2 dif x)
```

#m

#math.equation(block: true, eval(m.text, mode: "math"))

= Typst Markup

_Source code of this file._

#raw(read("./demo-code.typ"), block: true, lang: "typ")
