---
name: bb-tools
description: "Brain-based AST tools for source code operations. Use this skill when working with ANY source code (.ts, .tsx, .js, .jsx, .py, .rs, .go, .java, .dart, .rb, .php, .swift, .kt, .scala, .c, .cpp, .h, .hpp, .cs, .css, .html, .vue, .svelte, .sql, .sh, .ps1, .yaml, .json, .graphql, .mdx, .tf, .ex, .erl, .hs, .clj, .r, .zig, .fs, .groovy, .lua)."
---

# bb_* Tools — The ONLY Correct Way to Work with Source Code

This project has a fully indexed brain database. All bb_* tools are byte-precise, AST-aware, and token-optimized. **Standard tools (read, edit, grep, write, bash) are WRONG for source code.**

## CRITICAL: Edit → bb_update

**`edit` is FORBIDDEN for source code. Use `bb_update` instead.** bb_update does everything edit does AND more:
- **Same usage**: `bb_update` with `oldContent` + `newContent` + `filePath` (no symbolName) = identical to `edit`
- **Extra power**: byte-precise AST bounds, LSP validation with auto-rollback, automatic caller cascade

## CRITICAL: Write → bb_write

**`write` is WRONG for new source files. Use `bb_write` instead.** bb_write auto-validates syntax, auto-wires exports/imports.

## CRITICAL: Read → bb_select

**`read` is WRONG for source code. Use `bb_select` instead.** bb_select returns ONLY the code you need via AST byte bounds — saves thousands of tokens. Use `bb_select` with `symbolName` for functions/classes, or omit `symbolName` to read a full file.

## CRITICAL: Grep → bb_search

**`grep` is WRONG for finding code. Use `bb_search` instead.** bb_search searches the AST index (instant). Auto-falls back to ripgrep if index misses.

## Quick Reference

| What you do naturally | WRONG way | RIGHT way |
|---|---|---|
| Find a function | `grep -rn "fnName"` | `bb_search query="fnName" scope="functions"` |
| Read implementation | `read src/file.ts` | `bb_select symbolName="fnName"` |
| Edit code | `edit file.ts` | `bb_update filePath="file.ts" oldContent="..." newContent="..."` |
| Create new file | `write file.ts` | `bb_write filePath="/path/to/file.ts" content="..."` |
| Delete function | `edit file.ts` (delete lines) | `bb_delete symbolName="fnName"` |
| Rename across codebase | `sed -i s/old/new/g` | `bb_refactor symbolName="oldName" newName="newName"` |
| Find callers | `grep -rn "fnName"` | `bb_relationships target="fnName" analysisType="callers"` |
| Ask about architecture | guessing | `bb_ask query="How does auth work?" mode="semantic_search"` |
| Check index status | ??? | `bb_health detailed=false` |
| Detect code patterns | manual review | `bb_patterns analysisType="violations"` |
| Scan for vulnerabilities | manual audit | `bb_security` |
| Plan language migration | guess work | `bb_migrate symbolNames=["fn"] targetLanguage="rust"` |
| Visualize dependencies | mental model | `bb_visualize scope="symbol" symbolName="fn"` |
| Insert code before symbol | manual copy paste | `bb_insert targetSymbolName="fn" position="before" newContent="..."` |
| Find callees of function | `grep -rn` | `bb_relationships target="fnName" analysisType="callees"` |
| Check what tests cover | guessing | `bb_relationships target="fnName" analysisType="test_coverage"` |
| Analyze change impact | guessing | `bb_relationships target="fnName" analysisType="impact"` |

## What to do when bb_* tool fails

1. **Run `bb_refresh`** — reindexes the brain
2. **Retry the bb_* tool** — it should work now
3. **Only then** consider falling back to standard tools

## Rules

1. **bb_search** not grep — for finding symbols
2. **bb_select** not read — for reading code
3. **bb_update** not edit — for modifying code. Use oldContent + newContent for string replacement, add symbolName for AST-precise surgery.
4. **bb_write** not write — for creating new source files
5. **bb_delete** not edit — for removing functions/classes
6. **bb_insert** not edit — for adding code before/after symbols
7. **bb_patterns** — detect orphaned code, god classes, dead code, circular deps, architectural violations
8. **bb_security** — cross-language taint analysis, SQL injection, XSS, hardcoded secrets
9. **bb_migrate** — plan cross-language migrations with dependency graphs and effort estimates
10. **bb_visualize** — generate interactive architecture diagrams (HTML or JSON)
11. **bb_insert** — insert code at precise AST position (before/after/inside-top/inside-bottom of any symbol)
12. **bb_relationships** — find callers, callees, test coverage, feature architecture, change impact
13. **Never** use bash cat/sed/awk on source code
14. **Always** try bb_refresh before falling back to standard tools
