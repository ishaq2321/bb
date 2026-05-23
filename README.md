<div align="center">
  <img src="logo.svg" width="128" alt="Backbencher Logo" />
  <h1>Backbencher (bb)</h1>
  <p><b>AST-Native Code Intelligence for AI</b></p>
  <p>Index your entire codebase into a local SQLite brain. Give AI tools byte-precise access to symbols, call graphs, relationships, and cross-language intelligence across 39 languages.</p>

  <a href="https://backbencher.cc">Website</a> •
  <a href="https://backbencher.cc/docs">Documentation</a> •
  <a href="https://backbencher.cc/tools">All 15 Tools</a>
</div>

---

## What is Backbencher?

**bb** is a drop-in replacement for OpenCode that adds a **local brain database**. It parses your entire codebase using Tree-sitter AST parsing and stores every symbol, relationship, and import in a local SQLite database. 15 brain tools (`bb_*`) give the AI byte-precise, AST-aware access to your code — replacing grep, read, and edit entirely.

## Why Backbencher?

| Standard AI Coding | With Backbencher |
|---|---|
| `grep -rn "fnName"` scans raw text | `bb_search` queries the AST index — instant, exact |
| `read file.ts` loads entire file | `bb_select` returns ONLY the function's code — saves tokens |
| `edit` does blind string replace | `bb_update` uses AST byte bounds, LSP validation, auto-cascade |
| No idea who calls what | `bb_relationships` shows exact call graph |
| Guesses about architecture | `bb_ask` does semantic search across entire codebase |
| Cross-language? Hopeless | 39 language parsers, cross-language intelligence |

## Quick Start

```bash
# 1. Install
curl -fsSL https://backbencher.cc/install.sh | bash

# 2. Go to your project and index
cd your-project
bb brain

# 3. Load the skill (teaches AI to use brain tools)
# In the bb TUI, type: /skills bb-tools
# Or add to your config:
bb skill install https://github.com/ishaq2321/bb/blob/main/skill/SKILL.md

# 4. Chat with AI — it now uses bb_* tools
```

## The Brain

Run `bb brain` once to index your project. The brain:

- **39 languages**: TypeScript, Python, Rust, Go, Java, Dart, C/C++, Ruby, PHP, Swift, Kotlin, Scala, Elixir, Haskell, Lua, Zig, C#, F#, R, SQL, Bash, PowerShell, and more
- **Symbols**: Every function, class, method, variable — with byte-precise boundaries
- **Relationships**: Every call, import, export, inheritance — pre-computed
- **Cross-language**: Tracks Python calling JavaScript, Dart calling Swift, etc.
- **Incremental**: Only re-indexes changed files on subsequent runs
- **Local & Private**: 100% on your machine, no data leaves

## The Skill

**Without the skill, bb is just another OpenCode.** The `bb-tools` skill teaches the AI to use the 15 brain tools for all source code operations.

Load it once per project:
```bash
# In bb TUI:
/skills bb-tools

# Or via CLI:
bb skill install https://github.com/ishaq2321/bb/blob/main/skill/SKILL.md
```

The skill maps every natural operation to the correct brain tool:

| You want to... | AI uses |
|---|---|
| Find a function | `bb_search` |
| Read implementation | `bb_select` |
| Edit code | `bb_update` |
| Create new file | `bb_write` |
| Delete symbol | `bb_delete` |
| Insert code | `bb_insert` |
| Rename everywhere | `bb_refactor` |
| Find callers/callees | `bb_relationships` |
| Ask architecture | `bb_ask` |
| Check patterns | `bb_patterns` |
| Security scan | `bb_security` |
| Migration plan | `bb_migrate` |
| Visualize deps | `bb_visualize` |
| Check health | `bb_health` |
| Reindex | `bb_refresh` |

## Installation

### macOS & Linux
```bash
curl -fsSL https://backbencher.cc/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://backbencher.cc/install.ps1 | iex
```

### Manual Download
Download the latest binary from [GitHub Releases](https://github.com/ishaq2321/bb/releases) for your platform:
- `bb-linux-x64` — Linux x86_64
- `bb-linux-arm64` — Linux ARM64
- `bb-darwin-x64` — macOS Intel
- `bb-darwin-arm64` — macOS Apple Silicon
- `bb-windows-x64.exe` — Windows x64

```bash
chmod +x bb-* && sudo mv bb-* /usr/local/bin/bb
```

## Project Structure

- `.git` — Your git repository (used for project identification)
- `~/.local/share/opencode/brain/` — Brain databases (one per project)
- `~/.config/opencode/` — Global config, plugins, skills
- `.opencode/skills/` — Project-level skills

## Version

**Current: 1.0.16-preview**

## Support

- **Bugs & Features:** [GitHub Issues](https://github.com/ishaq2321/bb/issues)
- **Support:** `support@backbencher.cc`
- **General:** `info@backbencher.cc`
