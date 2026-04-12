# AST Analyzers (The Native Brain)

Backbencher uses **Tree-sitter**, a compiler-grade incremental parsing system, to analyze your code. Instead of matching text with regular expressions (which breaks easily), Backbencher builds a true Abstract Syntax Tree (AST) of your project.

---

## 1. Why AST over Regex?

When you ask traditional tools to "Find the `login` function", they might use `grep -r "function login"`. This fails when:
- The function is an arrow function (`const login = () =>`).
- The function is a class method (`async login() {`).
- The word "login" appears in a comment or a variable name.

**Backbencher's AST Analyzer:**
- Natively understands syntax for 26+ languages.
- Identifies the exact byte boundaries of every function, class, and method.
- Automatically handles scopes, closures, and imports.

## 2. Polyglot Capabilities

The engine is inherently polyglot. It seamlessly analyzes and cross-references relationships across different languages within the same workspace.

**Currently Supported Languages:**
- TypeScript, JavaScript, JSX, TSX
- Python
- Rust
- Go
- Java
- C, C++, C#
- Ruby, PHP, Swift, Kotlin
- Dart, Lua, Clojure, Haskell, Elixir
- SQL, HTML, CSS, JSON, YAML

## 3. How Backbencher Edits Code

Because Backbencher knows the exact coordinates of every symbol in your project, it uses tools like `bb_update` and `bb_insert` to perform **surgical modifications**. 

Instead of passing a diff or trying to `sed` replace text, the AI simply targets a symbol name (e.g., `AuthService.login`). The AST engine extracts the JIT context, passes it to the AI, and then perfectly splices the newly generated code back into the exact byte-bounds, guaranteeing zero indentation or syntax corruption.
