# Core Intelligence Tools: bb_search & bb_select

Backbencher OS replaces primitive command-line utilities (like `grep` and `cat`) with AST-aware intelligence tools that actually understand the structure of your code. 

## `bb_search` (Intelligent Codebase Search)

Stop fighting with regex. `bb_search` uses the project's native Brain index to find functions, classes, variables, and concepts instantly. 

- **Syntax & Semantics:** Find exactly what you are looking for by narrowing the scope to `functions`, `classes`, or `files`.
- **Semantic Search:** Don't know the exact function name? Use `scope="semantic"` to search by concept (e.g., "how do we authenticate users").
- **Context-Aware:** Returns results with context, parameters, and complexity metrics attached.

## `bb_select` (Surgical Context Extraction)

Never dump entire files into an LLM context window again. `bb_select` is "Engine 1" of our Dual-Engine Codebase OS. 

- **Precision Snippets:** Provide a symbol name (like `AuthService`), and it will surgically extract just that class or function directly from the file.
- **Automatic Dependencies:** When you select a function, `bb_select` automatically pulls in the definitions of the interfaces and types it uses, giving the AI the exact context it needs to write perfect code.
- **Smart Outlines:** If you try to read a massive 2,000-line file, it will automatically generate a structural outline of the file's classes and methods instead of flooding your terminal.
