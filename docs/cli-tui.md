# The CLI & Intelligence Dashboard

Backbencher (bb) includes a powerful suite of CLI commands under the `bb brain` namespace. These commands allow you to manage, monitor, and optimize the intelligence engine that powers your AI agents.

## Core Commands

### 1. `bb brain status`
This is your primary dashboard. It provides a real-time overview of your project's intelligence level, memory usage, and indexing progress.

**What it shows:**
- **Status & Progress:** Whether the project is ready, currently indexing, or waiting.
- **Memory Usage:** Current RAM consumption and database connection counts.
- **Intelligence Statistics:** Total files analyzed, symbols extracted, and cross-file relationships mapped.
- **Auto-Indexer:** Whether the background watcher is currently monitoring for file changes.

### 2. `bb brain init`
Initializes the brain database for a new project. This sets up the necessary local SQLite schema and prepares the environment for indexing.

### 3. `bb brain index`
Forces a manual deep-scan of your project. While Backbencher automatically watches for file changes and updates the brain incrementally, you can use this command if you've made massive external changes (like switching git branches or running a large `npm install`) and want to ensure perfect sync.

### 4. `bb brain optimize`
Runs database optimization. For large projects, the local SQLite database can grow. This command runs `VACUUM`, `ANALYZE`, and WAL checkpoints to ensure queries remain lightning fast.

## Understanding the Metrics

When you run `bb brain status`, you'll see a breakdown of your project's intelligence:

- **Symbols:** Functions, classes, interfaces, and variables. The higher this number, the more granular the AI's understanding of your code.
- **Relationships:** The map of how your code connects (callers, callees, implementations, inheritance). This is what enables Backbencher to predict side-effects when you change code.
- **Temporal Patterns:** Found via Git history, these indicate files that are frequently modified together.

You can also run `bb brain stats` to see a leaderboard of intelligence across all projects on your machine.