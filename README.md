<div align="center">
  <img src="logo.svg" width="128" alt="Backbencher OS Logo" />
  <h1>Backbencher (bb)</h1>
  <p><b>The Dual-Engine Codebase OS</b></p>
  <p>Stop AI from breaking your code. Surgical AST precision with 100% local SQLite Brain + AI-powered intelligence.</p>

  <a href="https://backbencher.cc">Website</a> •
  <a href="https://backbencher.cc/docs">Documentation</a> •
  <a href="https://backbencher.cc/privacy">Privacy Policy</a>
</div>

---

## What is Backbencher?

**bb** is an AI-powered CLI tool that understands your entire codebase. Unlike other AI coding tools that blindly modify files, bb uses:

1. **Local SQLite Brain** - Parses your entire codebase into a local database using Tree-sitter AST parsing
2. **AI Intelligence Layer** - Pre-flight checks for test coverage, impact analysis, risk assessment, and cascading updates

**Result:** When you ask bb to rename a function, it:
- Finds all callers automatically
- Updates them all (not just the definition)
- Won't let you break `buildAll()` when you rename `build()`
- Blocks high-risk changes unless you explicitly approve

## Key Features

### 🧠 Codebase Intelligence
- **30+ language parsers** via Tree-sitter (Dart, TypeScript, Python, Rust, Go, Java, etc.)
- **Symbol relationships** - know exactly who calls whom
- **Test coverage tracking** - knows which tests cover which functions
- **Gravity scores** - PageRank-style importance ranking of your code

### 🔄 Safe Refactoring (Cascade Update)
```bash
bb update --symbolName "build" --newContent "Future<void> builder() async {}" --autoUpdateCallers true
```
- Automatically finds and updates all callers
- **Fixed**: Won't accidentally rename `buildAll()` → `builderAll()`
- Uses negative lookahead regex: `\bbuild(?![A-Za-z0-9_])\s*\(`

### 🚫 Risk Blocking
```bash
bb update --symbolName "authenticate" --newContent "..." --force true
```
- bb **BLOCKS** high-risk operations by default
- Shows test coverage, impact analysis, breaking change likelihood
- You must pass `--force true` to override (after seeing the risks)

### 📊 4-Pillar Intelligence System
1. **Temporal** - Git history predictions (files edited together)
2. **Test** - Coverage intelligence (which tests cover what)
3. **Gravity** - Code importance ranking (most called = highest priority)
4. **Patterns** - Anti-pattern detection (god classes, circular deps, dead code)

### 🔒 100% Local & Private
- All code analysis happens locally
- SQLite brain stored on YOUR machine
- Bring your own API key (supports Anthropic, OpenAI, local models)
- Works offline

## Installation

### macOS & Linux
```bash
curl -fsSL https://backbencher.cc/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://backbencher.cc/install.ps1 | iex
```

## Quickstart

```bash
# 1. Navigate to your project
cd your-project

# 2. Index your brain (one-time, creates local SQLite database)
bb brain index

# 3. Ask questions about your codebase
bb ask "why is our auth system structured this way?"

# 4. Safely rename functions (updates all callers automatically)
bb update --symbolName "build" --newContent "Future<void> builder() async {}" --autoUpdateCallers true

# 5. Check relationships before changing
bb relationships --target "processOrder" --analysisType callers

# 6. Detect code issues
bb patterns --analysisType violations
```

## The Tools

| Tool | Purpose |
|------|---------|
| `bb_update` | Modify code with surgical precision + cascade updates |
| `bb_delete` | Remove symbols with cascading protection |
| `bb_ask` | Ask architecture questions with verified answers |
| `bb_relationships` | Query callers/callees/impact |
| `bb_patterns` | Detect god classes, dead code, violations |
| `bb_search` | Find symbols with semantic search |
| `bb_select` | Read code with exact byte boundaries |
| `bb_security` | Scan for vulnerabilities |

## Version

**Current: 1.0.9-preview**

## About This Repository

This is the public distribution hub for bb binaries and issue tracking.

**Core source code** for the Dual-Engine Codebase OS remains private.

## Support

- **Bugs & Features:** [GitHub Issues](https://github.com/ishaq2321/bb/issues)
- **Support:** `support@backbencher.cc`
- **General:** `info@backbencher.cc`
- **Legal:** `legal@backbencher.cc`