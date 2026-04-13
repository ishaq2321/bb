#!/usr/bin/env bash
set -e

# Backbencher OS Installer (macOS & Linux)
# This script downloads the pre-compiled, standalone, obfuscated binary.

VERSION="${VERSION:-v1.0.5-preview}"

# Ensure VERSION starts with "v" (to match GitHub release tags)
if [[ $VERSION != v* ]]; then
    VERSION="v${VERSION}"
fi
REPO="ishaq2321/bb"

echo "🚀 Installing Backbencher (bb) - The Dual-Engine Codebase OS..."
echo ""

# 1. Detect OS and Architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

if [ "$OS" = "darwin" ]; then
    if [ "$ARCH" = "x86_64" ]; then
        TARGET="opencode-darwin-x64"
        EXT="zip"
    elif [ "$ARCH" = "arm64" ]; then
        TARGET="opencode-darwin-arm64"
        EXT="zip"
    else
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
    fi
elif [ "$OS" = "linux" ]; then
    # Detect musl vs glibc
    if ldd --version 2>&1 | grep -q musl; then
        LIBC="-musl"
    else
        LIBC=""
    fi
    
    if [ "$ARCH" = "x86_64" ]; then
        TARGET="opencode-linux-x64${LIBC}"
        EXT="tar.gz"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        TARGET="opencode-linux-arm64${LIBC}"
        EXT="tar.gz"
    else
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
    fi
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

# Download URL from GitHub Releases
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${VERSION}/${TARGET}.${EXT}"

# 2. Setup installation directory
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# 3. Download the standalone binary
echo "⬇️  Downloading Backbencher for $TARGET..."
echo "   URL: $DOWNLOAD_URL"
echo ""

if command -v curl >/dev/null 2>&1; then
    curl -fSL "$DOWNLOAD_URL" -o "$TEMP_DIR/bb.${EXT}" --progress-bar
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$TEMP_DIR/bb.${EXT}" "$DOWNLOAD_URL" --show-progress
else
    echo "❌ Error: curl or wget is required to download the binary."
    exit 1
fi

# 4. Extract the binary
echo "📦 Extracting..."
if [ "$EXT" = "tar.gz" ]; then
    tar -xzf "$TEMP_DIR/bb.${EXT}" -C "$TEMP_DIR"
else
    unzip -q "$TEMP_DIR/bb.${EXT}" -d "$TEMP_DIR"
fi

# 5. Install the binary
mv "$TEMP_DIR/bb" "$INSTALL_DIR/bb"
find "$TEMP_DIR" -name "vec0.*" -exec mv {} "$INSTALL_DIR/" \; 2>/dev/null || true
chmod +x "$INSTALL_DIR/bb"

# 6. Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  Warning: $INSTALL_DIR is not in your PATH."
    echo "👉 Please add the following line to your ~/.bashrc, ~/.zshrc, or ~/.profile:"
    echo ""
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "🔑 Next steps:"
echo "   1. Get your free preview license at https://backbencher.cc"
echo "   2. Run 'bb' and enter your license key when prompted"
echo "   3. Start coding with AI-powered AST intelligence!"
echo ""
echo "📚 Documentation: https://backbencher.cc/docs"
echo "🐛 Issues: https://github.com/${REPO}/issues"
