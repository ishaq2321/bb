# Upgrading Backbencher (bb)

To get the latest features, intelligence models, and bug fixes, you should upgrade Backbencher regularly.

## How to Upgrade

Do not uninstall and reinstall. Simply run the upgrade command provided by your package manager or our installer script.

If you installed via npm:
```bash
npm update -g @opencode/bb
```

If you installed via curl (Linux/macOS):
```bash
curl -fsSL https://backbencher.cc/install.sh | bash
```

If you installed via PowerShell (Windows):
```powershell
iwr https://backbencher.cc/install.ps1 -useb | iex
```

## Post-Upgrade

After upgrading, you may want to ensure your brain indices are optimized and using the latest AST models:
```bash
bb brain optimize
```