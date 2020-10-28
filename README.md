# Ruby analysis support for CodeQL

Under development.

## Building the tools from source

[Install Rust](https://www.rust-lang.org/tools/install), then run:

```bash
cargo build --release
```

## Generating the database schema and QL library

The generated `ql/src/ruby.dbscheme` and `ql/src/codeql_ruby/ast.qll` files are included in the repository, but they can be re-generated as follows:

```bash
# Run the generator
cargo run --release -p ruby-generator
# Then auto-format the QL library
codeql query format -i ql/src/codeql_ruby/ast.qll
```
