#!/usr/bin/env bash
set -e

VERSION="1.0.16"
REPO="ishaq2321/bb"

echo "🚀 Installing Backbencher ${VERSION} for $(uname -s)..."

INSTALL_DIR="${HOME}/.local/bin"
TEMP_DIR=$(mktemp -d)
ARCH=$(uname -m)
OS=$(uname -s)

case "$ARCH" in
    x86_64)  ARCH_NAME="x64" ;;
    aarch64|arm64) ARCH_NAME="arm64" ;;
    *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
esac

case "$OS" in
    Linux)  OS_NAME="linux" ;;
    Darwin) OS_NAME="darwin" ;;
    *) echo "Unsupported OS: $OS" && exit 1 ;;
esac

BINARY_NAME="bb-${OS_NAME}-${ARCH_NAME}"
GZ_NAME="${BINARY_NAME}"

RELEASE_URL="https://github.com/${REPO}/releases/download/v${VERSION}/${GZ_NAME}"
CHECKSUM_URL="https://github.com/${REPO}/releases/download/v${VERSION}/checksums.txt"

echo "Installing Backbencher (bb) v${VERSION} for ${OS_NAME}-${ARCH_NAME}..."

mkdir -p "$INSTALL_DIR"

# Download gzipped binary
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$RELEASE_URL" -o "$TEMP_DIR/${GZ_NAME}" || { echo "Download failed"; exit 1; }
elif command -v wget >/dev/null 2>&1; then
    wget -q "$RELEASE_URL" -O "$TEMP_DIR/${GZ_NAME}" || { echo "Download failed"; exit 1; }
else
    echo "Neither curl nor wget found. Please install one of them."
    exit 1
fi

# Decompress
chmod +x "$TEMP_DIR/${BINARY_NAME}"

# Verify checksum if sha256sum available
if command -v sha256sum >/dev/null 2>&1; then
    curl -fsSL "$CHECKSUM_URL" -o "$TEMP_DIR/checksums.txt" 2>/dev/null || true
    if [ -f "$TEMP_DIR/checksums.txt" ]; then
        cd "$TEMP_DIR"
        # Extract the line for our binary
        EXPECTED=$(grep "${GZ_NAME}" checksums.txt | awk '{print $1}')
        if [ -n "$EXPECTED" ]; then
            ACTUAL=$(sha256sum "${GZ_NAME}" | awk '{print $1}')
            if [ "$EXPECTED" != "$ACTUAL" ]; then
                echo "⚠️ Checksum mismatch! Expected: $EXPECTED Got: $ACTUAL"
            fi
        fi
        cd - >/dev/null
    fi
fi

# Install
mv "$TEMP_DIR/${BINARY_NAME}" "$INSTALL_DIR/bb"
rm -rf "$TEMP_DIR"

echo ""

# Create default config with bb_* tool permissions (no TUI permission prompts)
CONFIG_DIR="$HOME/.config/opencode"
CONFIG_FILE="$CONFIG_DIR/opencode.json"
mkdir -p "$CONFIG_DIR"
if [ ! -f "$CONFIG_FILE" ]; then
  cat > "$CONFIG_FILE" << 'CONFEOF'
{
  "$schema": "https://backbencher.cc/config.json",
  "permission": {
    "bb_search": "allow",
    "bb_select": "allow",
    "bb_relationships": "allow",
    "bb_update": "allow",
    "bb_delete": "allow",
    "bb_insert": "allow",
    "bb_write": "allow",
    "bb_refresh": "allow",
    "bb_health": "allow",
    "bb_migrate": "allow",
    "bb_refactor": "allow",
    "bb_visualize": "allow",
    "bb_ask": "allow",
    "bb_security": "allow",
    "bb_patterns": "allow"
  }
}
CONFEOF
  echo "Default config created with bb_* tool permissions"
else
  # Merge bb_* permissions into existing config
  TMPFILE=$(mktemp)
  node -e "
    const fs = require('fs');
    const cfg = JSON.parse(fs.readFileSync('$CONFIG_FILE','utf8'));
    cfg.permission = cfg.permission || {};
    const tools = ['bb_search','bb_select','bb_relationships','bb_update','bb_delete','bb_insert','bb_write','bb_refresh','bb_health','bb_migrate','bb_refactor','bb_visualize','bb_ask','bb_security','bb_patterns'];
    tools.forEach(t => { if (!cfg.permission[t]) cfg.permission[t] = 'allow'; });
    fs.writeFileSync('$TMPFILE', JSON.stringify(cfg, null, 2));
  " 2>/dev/null && mv "$TMPFILE" "$CONFIG_FILE" || echo "Skipped config merge (no node)"
fi


# Install bb-tools skill
echo ""
echo "📋 Installing bb-tools skill..."
SKILL_DIR="${HOME}/.config/opencode/skills/bb-tools"
mkdir -p "$SKILL_DIR"
SKILL_URL="https://raw.githubusercontent.com/ishaq2321/bb/master/skill/SKILL.md"
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$SKILL_URL" -o "$SKILL_DIR/SKILL.md" && echo "✅ bb-tools skill installed" || echo "⚠️  Download failed (use /skills bb-tools in TUI)"
elif command -v wget >/dev/null 2>&1; then
    wget -q "$SKILL_URL" -O "$SKILL_DIR/SKILL.md" 2>/dev/null && echo "✅ bb-tools skill installed" || echo "⚠️  Download failed"
fi

echo "✅ Installed to $INSTALL_DIR/bb"
echo "Run: bb --version"
