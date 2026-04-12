# Utility & Refactoring Tools

Backbencher OS includes a suite of God-Mode utilities that operate across the entire codebase simultaneously, leveraging the AST database and Language Server Protocols.

## `bb_refactor` (Atomic Cross-File Rename)
Safely rename a variable, function, or class across your entire project.
- **True Safety:** Unlike a global Find & Replace that might accidentally rename a string inside a comment or a variable with the same name in a different scope, `bb_refactor` uses the Language Server (LSP) and the AST database to ensure only the exact symbol and its actual callers are renamed.

## `bb_security` (Proactive Security Scanner)
Scan your codebase for vulnerabilities without leaving your editor.
- **Cross-Language Taint Analysis:** It tracks data flows across different languages (e.g., from a TypeScript frontend to a Python backend) to ensure user input is sanitized before hitting the database.
- **Auto-Fixing:** When it finds a vulnerability, it automatically instructs the AI agent on exactly which file and line to patch.

## `bb_migrate` (Polyglot Migration Assistant)
Porting a service from TypeScript to Rust? Or Python to Go?
- **Dependency Mapping:** Give it a component, and it will analyze the libraries it uses and suggest the equivalent libraries in your target language.
- **Surgical Extraction:** It extracts the exact code snippet and hands it to the AI for immediate translation.

## `bb_visualize` (3D Architecture Map)
Instantly generate an interactive 3D visualization of your entire codebase architecture.
- It exports a `bb-brain-map.html` file into your project root. Open it in any browser to explore your dependency graph visually.

## `bb_refresh` (Manual Index Trigger)
While the `bb` watcher automatically indexes files as you save them, you can use this tool to manually force the OS to rebuild the AST index if you've just pulled down a massive branch from Git.
