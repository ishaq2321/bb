# Backbencher (bb) Installer - v1.0.16-preview
# Run in PowerShell:irm https://backbencher.cc/install.ps1 | iex

$VERSION = "1.0.16-preview"
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
$GZ_NAME = "${BINARY_NAME}"
$RELEASE_URL = "https://github.com/ishaq2321/bb/releases/download/v${VERSION}/${GZ_NAME}"
$CHECKSUM_URL = "https://github.com/ishaq2321/bb/releases/download/v${VERSION}/checksums.txt"

Write-Host "Installing Backbencher (bb) v${VERSION} for ${OS}-${ARCH_NAME}..." -ForegroundColor Cyan

# Create install directory
if (!(Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Path $INSTALL_DIR -Force | Out-Null
}

# Download gzipped binary
$BINARY_PATH = Join-Path $TEMP_DIR $BINARY_NAME
try {
    Invoke-WebRequest -Uri $RELEASE_URL -OutFile $BINARY_PATH -UseBasicParsing
} catch {
    Write-Error "Download failed: $_"
    exit 1
}

# Decompress using .NET
$OUTPUT_PATH = Join-Path $TEMP_DIR $BINARY_NAME
try {
    $src = [System.IO.File]::OpenRead($GZ_PATH)
    $dst = [System.IO.File]::Create($OUTPUT_PATH)
    $gzip = New-Object System.IO.Compression.GZipStream($src, [System.IO.Compression.CompressionMode]::Decompress)
    $gzip.CopyTo($dst)
    $gzip.Close()
    $dst.Close()
    $src.Close()
} catch {
    Write-Error "Decompression failed: $_"
    Remove-Item $GZ_PATH -ErrorAction SilentlyContinue
    exit 1
}
Remove-Item $GZ_PATH -ErrorAction SilentlyContinue

# Verify checksum
$CHECKSUM_PATH = Join-Path $TEMP_DIR "checksums.txt"
try {
    Invoke-WebRequest -Uri $CHECKSUM_URL -OutFile $CHECKSUM_PATH -UseBasicParsing -ErrorAction SilentlyContinue
} catch {}

if (Test-Path $CHECKSUM_PATH) {
    $content = Get-Content $CHECKSUM_PATH -Raw
    $line = ($content -split "`n" | Where-Object { $_ -match [regex]::Escape($GZ_NAME) }) | Select-Object -First 1
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

# Create default config with bb_* tool permissions (no TUI prompts)
$CONFIG_DIR = "$HOME\.config\opencode"
$CONFIG_FILE = "$CONFIG_DIR\opencode.json"
if (!(Test-Path $CONFIG_DIR)) { New-Item -ItemType Directory -Path $CONFIG_DIR -Force | Out-Null }
if (!(Test-Path $CONFIG_FILE)) {
  $defaultConfig = @'
{
  "$schema": "https://backbencher.cc/config.json",
  "permission": {
    "bb_write": "allow",
    "bb_update": "allow",
    "bb_delete": "allow",
    "bb_insert": "allow",
    "bb_refresh": "allow",
    "bb_refactor": "allow"
  }
}
'@
  Set-Content -Path $CONFIG_FILE -Value $defaultConfig
}

Write-Host "✅ Installed to $FINAL_PATH" -ForegroundColor Green
Write-Host "Run: bb --version"
