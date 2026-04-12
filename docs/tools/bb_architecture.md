# Architectural Intelligence Tools

Backbencher OS doesn't just read strings; it understands the entire dependency graph, architectural health, and historical workflow of your project.

## `bb_relationships` (Dependency & Impact Analyzer)
Stop manually searching for `import` statements or doing global string searches to figure out what breaks when you change a function.
- **Call Graphs:** Find out exactly what calls a specific function (`callers`), or what it calls (`callees`).
- **Deep Tracing:** Ask the OS to recursively trace the callers all the way back to the root entry point (e.g., from a database query back up to the REST API route).
- **Impact Analysis:** See exactly how many files and tests will be impacted if you modify a specific class.

## `bb_patterns` (Codebase Health & Temporal Predictions)
A proactive engine that assesses your project's architecture and predicts what you should do next.
- **Dead Code Detection:** Instantly find "orphaned" code that is no longer being called anywhere in the project.
- **Complexity & Test Gaps:** Detects "God Classes" and highly complex functions that are missing test coverage.
- **Workflow Predictions:** Analyzes your Git commit history to predict which files usually change together. If you update `user.model.ts`, it will remind you to update `user.schema.ts`.

## `bb_ask` (Architectural Oracle)
Ask free-form questions about your project architecture.
- **Hallucination Prevention:** When `bb_ask` answers your question, it cross-references every function name it mentions against the live AST database to ensure it isn't hallucinating fake code.
- **Conceptual Queries:** "How does the authentication flow work?" or "Where is the Stripe payment gateway initialized?"
