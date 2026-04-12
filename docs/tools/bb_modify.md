# Code Modification Tools: bb_update, bb_insert, bb_delete

Editing code via an AI agent has historically been brittle. Primitive tools like `sed`, `awk`, or `edit` rely on fragile line numbers or string replacements that break as soon as the file changes.

Backbencher OS introduces **AST Surgical Modification**.

## `bb_update` (The AST Scalpel)
Completely rewrites a specific function, class, or symbol.
- **No Line Numbers:** You just tell it to replace `AuthService`. It finds the exact start and end bytes of the class and replaces it perfectly.
- **Sub-Symbol Targeting:** Need to update just one `if` statement inside a 500-line function? You can target it perfectly without replacing the whole function.

## `bb_insert` (The AST Injector)
Safely inserts new code into a file by anchoring it to an existing symbol.
- **Relative Positioning:** You can insert new code `before` or `after` a function, or inject it `inside-top` / `inside-bottom` of a class body.
- **Auto-Imports:** Tell `bb_insert` what dependencies your new code needs, and it will surgically inject the `import` statements at the top of the file without breaking existing imports.

## `bb_delete` (The AST Remover)
Surgically removes a symbol from the codebase.
- **Cascading Protection:** If you try to delete a function that is actively being called by 5 other files, `bb_delete` will block the deletion and warn you, preventing you from accidentally orphaned code.
- **Auto-Pruning:** When you delete a function, it automatically cleans up and removes any unused `import` statements that were only used by that function.

## Automatic Type-Safety (LSP Rollback)
All three modification tools (`bb_update`, `bb_insert`, `bb_delete`) feature an automatic LSP (Language Server Protocol) safety gate. If the AI writes code that introduces a syntax error, type error, or semantic failure, the tool will instantly **revert the change** and return the exact compiler errors to the AI, forcing it to try again.
