# Backbencher (bb) Installer - v1.0.12-preview
# Run in PowerShell:irm https://backbencher.cc/install.ps1 | iex

$VERSION = "1.0.12-preview"
$INSTALL_DIR = "$HOME\.local\bin"
$TEMP_DIR = [System.IO.Path]::GetTempPath()
$ARCH = $env:PROCESSOR_ARCHITECTURE
$OS = "windows"

# Detect architecture
if ($ARCH -eq "AMD64") {
    $ARCH_NAME = "x64"
} elseif ($ARCH -eq "ARM64") {
    $ARCH_NAME = "arm64"
} else {
    Write-Error "Unsupported architecture: $ARCH"
    exit 1
}

$BINARY_NAME = "bb-${OS}-${ARCH_NAME}.exe"
$RELEASE_URL = "https://github.com/ishaq2321/bb/releases/download/v${VERSION}/${BINARY_NAME}"
$CHECKSUM_URL = "https://github.com/ishaq2321/bb/releases/download/v${VERSION}/checksums.txt"

Write-Host "Installing Backbencher (bb) v${VERSION} for ${OS}-${ARCH_NAME}..." -ForegroundColor Cyan

# Create install directory
if (!(Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
}

# Download binary
$OUTPUT_PATH = Join-Path $TEMP_DIR "bb.exe"
try {
    Invoke-WebRequest -Uri $RELEASE_URL -OutFile $OUTPUT_PATH -UseBasicParsing
} catch {
    Write-Error "Download failed: $_"
    exit 1
}

# Verify checksum
$CHECKSUM_PATH = Join-Path $TEMP_DIR "checksums.txt"
try {
    Invoke-WebRequest -Uri $CHECKSUM_URL -OutFile $CHECKSUM_PATH -UseBasicParsing -ErrorAction SilentlyContinue
} catch {}

if (Test-Path $CHECKSUM_PATH) {
    $content = Get-Content $CHECKSUM_PATH -Raw
    $line = ($content -split "`n" | Where-Object { $_ -match "bb-windows-${ARCH_NAME}\.exe" }) | Select-Object -First 1
    if ($line) {
        $expected = ($line -split '\s+')[0]
        $actual = (Get-FileHash -Algorithm SHA256 -Path $OUTPUT_PATH).Hash.ToLower()
        if ($expected -ne $actual) {
            Write-Error "Checksum verification failed!"
            Remove-Item $OUTPUT_PATH -ErrorAction SilentlyContinue
            exit 1
        }
        Write-Host "✅ Checksum verified" -ForegroundColor Green
    }
}

# Install
$FINAL_PATH = Join-Path $INSTALL_DIR "bb.exe"
Copy-Item -Path $OUTPUT_PATH -Destination $FINAL_PATH -Force
Remove-Item $OUTPUT_PATH -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "✅ Installed to $FINAL_PATH" -ForegroundColor Green
Write-Host "Run: bb --version"