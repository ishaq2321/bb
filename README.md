<div align="center">
  <img src="logo.svg" width="128" alt="Backbencher Logo" />
  <h1>Backbencher (bb)</h1>
  <p><b>AST-Native Code Intelligence for AI</b></p>
  <p>Index your entire codebase into a local SQLite brain. 25+ tools give AI byte-precise access to symbols, call graphs, relationships, and cross-language intelligence across 40+ languages.</p>

  <a href="https://backbencher.cc">Website</a> •
  <a href="https://backbencher.cc/docs">Documentation</a>
</div>

---

## What is Backbencher?

**bb** parses your entire codebase using Tree-sitter AST parsing and stores every symbol, relationship, and import in a local SQLite database. 25+ brain tools (`bb_*`) give the AI byte-precise, AST-aware access to your code.

## Quick Start

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/ishaq2321/bb/master/install.sh | bash

# Index your project
cd your-project
bb brain --force          # first time (~3 min for 4,000 files)
bb brain                   # subsequent runs (seconds, incremental)

# Load the skill (teaches AI to use brain tools)
bb skill install https://github.com/ishaq2321/bb/blob/master/skill/SKILL.md
```

## What You Get

After indexing, the AI gets 25+ brain tools:

| Tool | What it does |
|------|-------------|
| `bb_search` | Instant AST-level symbol search |
| `bb_select` | Read exact byte range of any symbol — saves tokens |
| `bb_ask` | Semantic search across entire codebase (works offline, zero config) |
| `bb_relationships` | Full call graph — trace callers, callees, imports across languages |
| `bb_visualize` | Architecture map (interactive HTML + JSON export) |
| `bb_update` | AST-precise edits with byte bounds + dry-run diff |
| `bb_refactor` | Rename across all files with impact preview + dry-run |
| `bb_insert` | Insert code at exact AST positions with dry-run |
| `bb_delete` | Delete symbols with cascade detection |
| `bb_write` | Create new files with proper scaffolding |
| `bb_patterns` | Detect god classes, circular deps, feature envy, orphans, tight coupling (8 types) |
| `bb_security` | Scan for SQL injection, XSS, hardcoded secrets, command injection (10+ vuln types) |
| `bb_migrate` | Cross-language migration plans (30+ language pairs, effort/risk estimates) |
| `bb_feature` | Multi-layer feature tracing — tracks a feature across all 4 languages |
| `bb_health` | Codebase health dashboard (complexity, test coverage, patterns, taint flows) |
| `bb_refresh` | Re-index changed files only |
| `bb_trace` | Full call graph traversal with depth control |
| `bb_impact` | Impact analysis — what breaks if this changes |
| `bb_metrics` | Complexity, coupling, and maintainability metrics |
| `bb_explain` | Natural language explanation of any symbol |
| `bb_suggest` | AI-powered code suggestions based on patterns |
| `bb_doc` | Generate documentation for symbols |
| `bb_deps` | Dependency analysis — what does this depend on |
| `bb_review` | Code review with pattern and security checks |
| `bb_fix` | Suggest fixes for detected issues |
| `bb_scan` | Full project scan with all detectors |

**Every tool is AST-aware** — byte-precise boundaries, LSP-validated, cross-language by default.

## Semantic Search — Zero Configuration

`bb_ask` uses **embedded word vectors** that work offline with no setup. The vocabulary adapts to your project automatically.

```
$ bb brain --force
...
Generating semantic embeddings... 20,000 vectors (word vectors — offline)
```

**For higher quality (optional)**, add an API key to `bb.json`:

### OpenAI
```json
{
  "provider": { "openai": { "apiKey": "sk-..." } },
  "embedding_model": "openai/text-embedding-3-small"
}
```
Cost: ~$0.02 per 1M tokens. Best quality.

### Google AI Studio (free tier available)
```json
{
  "provider": { "google": { "apiKey": "AIzaSy..." } },
  "embedding_model": "google/gemini-embedding-001"
}
```
Get a key at [aistudio.google.com/apikey](https://aistudio.google.com/apikey). Free tier: 1,500 requests/day.

### Mistral
```json
{
  "provider": { "mistral": { "apiKey": "..." } },
  "embedding_model": "mistral/mistral-embed"
}
```

### Cohere
```json
{
  "provider": { "cohere": { "apiKey": "..." } },
  "embedding_model": "cohere/embed-english-v3.0"
}
```

### Any OpenAI-compatible endpoint
Works with Azure, NVIDIA NIM, Google Vertex AI, self-hosted models, or any service exposing `/v1/embeddings`:
```json
{
  "provider": { "nvidia": { "apiKey": "...", "baseURL": "https://..." } },
  "embedding_model": "nvidia/nv-embedqa-e5-v5"
}
```

After configuring any provider, run `bb brain --post` to regenerate embeddings.

## Configuration

Config lives in `bb.json` at your project root. This file is **not created automatically** — create it only to configure providers or override defaults.

```json
{
  "provider": {
    "openai": { "apiKey": "sk-..." },
    "google": { "apiKey": "AIzaSy..." },
    "mistral": { "apiKey": "..." }
  },
  "embedding_model": "openai/text-embedding-3-small"
}
```

## The Brain Database

- **Location**: `~/.local/share/opencode/brain/<git-hash>/brain.db`
- **Size**: ~700MB for 4,000 files / 588K symbols
- **Incremental**: Only re-indexes changed files (hash-based detection)
- **Force re-index**: `bb brain --force`
- **Post-processing only**: `bb brain --post` (resolution + embeddings + patterns)

## Supported Languages

TypeScript, JavaScript, Python, Dart, Go, Rust, Java, Kotlin, Swift, C, C++, C#, F#, Ruby, PHP, Elixir, Haskell, Lua, Zig, Scala, R, SQL, Bash, PowerShell, HTML, CSS, JSON, YAML, TOML, XML, Markdown, Vue, Erlang, Objective-C, Perl — **40+ languages** via Tree-sitter parsers.

## Installation

```bash
# macOS & Linux
curl -fsSL https://raw.githubusercontent.com/ishaq2321/bb/master/install.sh | bash

# Windows (PowerShell)
irm https://backbencher.cc/install.ps1 | iex

# Manual (from releases)
# Download from https://github.com/ishaq2321/bb/releases
chmod +x bb-* && sudo mv bb-* /usr/local/bin/bb
```

## Project Layout

| Path | Purpose |
|------|---------|
| `bb.json` | Project config (providers, embedding model) — create manually |
| `~/.local/share/opencode/brain/` | Brain databases (one per git repo) |
| `~/.config/opencode/` | Global config, plugins, skills |
| `.opencode/skills/` | Project-level skills |

## Version

**Current: 1.0.16**

## Support

- [GitHub Issues](https://github.com/ishaq2321/bb/issues)
- `support@backbencher.cc`
