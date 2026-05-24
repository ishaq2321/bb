#!/usr/bin/env bash
set -e

VERSION="1.0.16-preview"
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
echo "✅ Installed to $INSTALL_DIR/bb"
echo "Run: bb --version"
