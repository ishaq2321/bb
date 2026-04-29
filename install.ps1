# Backbencher Install Script for Windows
# Version: 1.0.8-preview

$VERSION = "1.0.8-preview"
$REPO = "ishaq2321/bb"
$FILE = "bb-win-x64.exe"
$DOWNLOAD_URL = "https://github.com/$REPO/releases/download/$VERSION/$FILE"

Write-Host "🚀 Installing Backbencher $VERSION..." -ForegroundColor Cyan
Write-Host ""

# Create install directory
$INSTALL_DIR = "$env:LOCALAPPDATA\backbencher"
New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null

# Download
Write-Host "⬇️  Downloading..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile "$INSTALL_DIR\bb.exe" -UseBasicParsing
} catch {
    Write-Host "❌ Download failed: $_" -ForegroundColor Red
    exit 1
}

# Test binary
Write-Host "🔧 Testing binary..." -ForegroundColor Cyan
& "$INSTALL_DIR\bb.exe" --version | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Binary test failed" -ForegroundColor Red
    exit 1
}

# Add to PATH
Write-Host "📁 Adding to PATH..." -ForegroundColor Cyan
$USER_PATH = [Environment]::GetEnvironmentVariable("PATH", "User")
if (-not $USER_PATH.Contains($INSTALL_DIR)) {
    [Environment]::SetEnvironmentVariable("PATH", "$USER_PATH;$INSTALL_DIR", "User")
    $env:PATH = "$env:PATH;$INSTALL_DIR"
}

Write-Host ""
Write-Host "✅ Backbencher $VERSION installed!" -ForegroundColor Green
Write-Host ""
Write-Host "🔑 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Get license: https://backbencher.cc" -ForegroundColor White
Write-Host "   2. Run: bb" -ForegroundColor White
Write-Host "   3. Enter license key when prompted" -ForegroundColor White
Write-Host ""
Write-Host "📚 Docs: https://backbencher.cc/docs" -ForegroundColor White
Write-Host "🐛 Issues: https://github.com/$REPO/issues" -ForegroundColor White
Write-Host ""
Write-Host "Run: bb --version" -ForegroundColor Cyan
