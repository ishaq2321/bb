<div align="center">
  <img src="logo.svg" width="128" alt="Backbencher OS Logo" />
  <h1>Backbencher OS (bb)</h1>
  <p><b>The Dual-Engine Codebase OS</b></p>
  <p>Stop AI from breaking your code. Surgical AST precision with a 100% local SQLite Brain.</p>

  <a href="https://backbencher.cc">Website</a> •
  <a href="https://backbencher.cc/docs">Documentation</a> •
  <a href="https://backbencher.cc/privacy">Privacy Policy</a>
</div>

---

## ⚡ What is Backbencher?

Other AI tools grep through your files like a drunk intern. **Backbencher (bb)** understands your code the way you do. Every function, every relationship, every dependency mapped instantly.

By parsing your entire codebase into a local SQLite database using Tree-sitter, `bb` allows LLMs to surgically query exact byte-boundaries and relationship graphs (Callers/Callees).

**Zero token waste. Zero broken builds.**

## 🚀 Installation

### macOS & Linux
```bash
curl -fsSL https://backbencher.cc/install.sh | bash
```

### Windows (PowerShell)
```powershell
irm https://backbencher.cc/install.ps1 | iex
```

## 🧠 Quickstart

1. **Get your free preview key** at [https://backbencher.cc](https://backbencher.cc)
2. **Navigate to your project:** `cd your-project`
3. **Index your Brain (Required!):** `bb brain index`
4. **Launch the TUI:** `bb`
5. **Connect your LLM:** `/connect`

## 🔒 100% Local & Secure

* **Bring Your Own Key (BYOK):** Use Anthropic, OpenAI, or local models.
* **Encrypted Prompts:** AES-256-GCM locally cached system prompts.
* **Offline Mode:** Keep coding offline for up to 7 days.
* **No Cloud Code:** Your source code never leaves your laptop. Only your prompt goes to the LLM.

## 📦 About this Repository

This repository serves as the public distribution hub for Backbencher binaries and issue tracking. The core source code for the proprietary Dual-Engine Codebase OS remains private to protect the AST logic engine and licensing models.

Please use the [Issues](https://github.com/ishaq2321/bb/issues) tab to report bugs or request features!
