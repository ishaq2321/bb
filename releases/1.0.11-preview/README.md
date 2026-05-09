# Backbencher (bb) v1.0.11-preview

## Release Notes

### New in v1.0.11-preview

- **Stable License System** - Device fingerprinting now uses UID + platform + arch + RAM (no more MAC addresses). Users no longer face false "device mismatch" errors on restart, VPN connect, or after hibernate.
- **Unblocked Bash Tool** - AI can now freely run shell commands. No more token-wasting redirects. Soft nudging via skills and system prompt instead of hard blocks.
- **Built-in bb-tool-guide Skill** - Pre-installed skill teaches AI when to prefer bb tools vs primitive bash commands. Available via `/skills` command.
- **Skills Bundled in Binary** - Built-in skills are now copied to `bin/skills/` during build, auto-discovered at runtime.
- **Consolidated Test Tools** - `bb_predict_tests` merged into `bb_relationships`. Single entry point for test_impact, test_gaps, and test_coverage analysis.
- **Brain Tools Fixed** - All 16 brain tools now have BrainService import, fresh index checks, proper error logging, no silent catches.
- **bash.ts False Positives Fixed** - `git checkout`, `cat filename.ts`, etc. no longer incorrectly blocked.
- **tree-sitter.wasm Path Fixed** - ENOENT errors resolved by removing bunfs virtual path defines.

### Installation

#### Linux & macOS
```bash
curl -fsSL https://raw.githubusercontent.com/ishaq2321/bb/main/releases/1.0.11-preview/install.sh | bash
```

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/ishaq2321/bb/main/releases/1.0.11-preview/install.ps1 | iex
```

## Downloads

| Platform | Binary | Compressed |
|---------|--------|-------------|
| Linux x64 | [bb-linux-x64](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-linux-x64) | [bb-linux-x64.gz](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-linux-x64.gz) |
| Linux ARM64 | [bb-linux-arm64](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-linux-arm64) | [bb-linux-arm64.gz](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-linux-arm64.gz) |
| macOS x64 | [bb-macos-x64](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-macos-x64) | - |
| macOS ARM64 | [bb-macos-arm64](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-macos-arm64) | - |
| Windows x64 | [bb-windows-x64.exe](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-windows-x64.exe) | [bb-windows-x64.exe.gz](https://github.com/ishaq2321/bb/releases/download/v1.0.11-preview/bb-windows-x64.exe.gz) |

## Verify Checksums

```bash
sha256sum -c checksums.txt
```

Full documentation: https://backbencher.cc
