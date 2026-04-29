#!/bin/bash
set -e

VERSION="1.0.8-preview"
REPO="ishaq2321/bb"

echo "🚀 Installing Backbencher ${VERSION}..."
echo ""

# Detect OS and Architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" == "Darwin" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        FILE="bb-macos-arm64"
    else
        FILE="bb-macos-x64"
    fi
elif [[ "$OS" == "Linux" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        FILE="bb-linux-x64"
    elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        FILE="bb-linux-arm64"
    else
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
    fi
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${VERSION}/${FILE}"

echo "⬇️  Downloading Backbencher ${VERSION} for ${FILE}..."
echo "   URL: ${DOWNLOAD_URL}"
echo ""

# Create temp directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Download
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$DOWNLOAD_URL" -o "$TEMP_DIR/bb"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TEMP_DIR/bb" "$DOWNLOAD_URL"
else
    echo "❌ Error: curl or wget is required"
    exit 1
fi

# Make executable
chmod +x "$TEMP_DIR/bb"

# Test binary
if ! "$TEMP_DIR/bb" --version >/dev/null 2>&1; then
    echo "❌ Error: Downloaded binary is not valid"
    exit 1
fi

# Install
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"
mv "$TEMP_DIR/bb" "$INSTALL_DIR/bb"

echo ""
echo "✅ Backbencher ${VERSION} installed to ${INSTALL_DIR}/bb"
echo ""

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "⚠️  Add to your PATH:"
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo "   Add this to ~/.bashrc, ~/.zshrc, or ~/.profile"
    echo ""
fi

echo "🔑 Next steps:"
echo "   1. Get license: https://backbencher.cc"
echo "   2. Run: bb"
echo "   3. Enter license key when prompted"
echo ""
echo "📚 Docs: https://backbencher.cc/docs"
echo "🐛 Issues: https://github.com/${REPO}/issues"
echo ""
echo "Run: bb --version"
