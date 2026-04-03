# Welcome to the Backbencher Community Hub! 👋

This repository is the official issue tracker and discussion board for **Backbencher (bb)**, the Dual-Engine Codebase OS.

Since the core engine is proprietary, this repository exists to distribute the binary releases and host the community.

## 🤝 How to contribute / participate

### 1. 💡 Ask Questions
Have a question about how to configure an MCP server? Wondering how `bb_select` works under the hood? **[Join the Discussions tab](https://github.com/ishaq2321/bb/discussions)!** This is the best place to ask questions without cluttering the issue tracker.

### 2. 🐛 Report Bugs
If you encounter a bug, syntax parsing failure, or TUI crash, please **[open an Issue](https://github.com/ishaq2321/bb/issues/new/choose)** using the Bug Report template.
*Please include your OS, architecture, and exact error output.*

### 3. ✨ Request Features
Want support for a new language parser (e.g. C# or Lua)? Want a new AI provider integrated? **[Open an Issue](https://github.com/ishaq2321/bb/issues/new/choose)** using the Feature Request template.

---

## 🛠️ Troubleshooting

**"libonnxruntime.so.1.14.0: cannot open shared object file" (Linux only)**
*   **Cause:** The standalone compiled binary may sometimes struggle to unpack its embedded native C++ libraries (like ONNX) on certain Linux distributions (like Alpine or older Ubuntu).
*   **Fix:** Ensure your system has the standard C/C++ libraries installed (`build-essential`). If the issue persists, please report it in the Issues tab so we can provide a statically linked fallback binary in the next release!