<#
.SYNOPSIS
    FileConverter Setup — installs FFmpeg and registers the NileSoft Shell context menu.

.DESCRIPTION
    1. Downloads portable FFmpeg (from GitHub releases) into ./tools/ffmpeg/
    2. Copies shell/file-converter.nss to NileSoft Shell's imports folder
    3. Adds   import 'imports/file-converter.nss'   to shell.nss (if not already present)
    4. Restarts shell.exe so the new menu is visible immediately

    Run this script once. Re-run anytime to repair or update.

.NOTES
    Requires PowerShell 5.1+ and an internet connection (for FFmpeg download).
    NileSoft Shell must already be installed at its default location.
#>

#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms

# ─── Paths ────────────────────────────────────────────────────────────────────

$ScriptDir      = Split-Path -Parent $MyInvocation.MyCommand.Path
$ToolsDir       = Join-Path $ScriptDir 'tools\ffmpeg'
$FfmpegBin      = Join-Path $ToolsDir  'bin\ffmpeg.exe'
$NilesoftDir    = 'C:\Program Files\Nilesoft Shell'
$NilesoftNss    = Join-Path $NilesoftDir 'shell.nss'
$NilesoftImport = Join-Path $NilesoftDir 'imports\file-converter.nss'
$LocalNss       = Join-Path $ScriptDir  'shell\file-converter.nss'
$NilesoftExe    = Join-Path $NilesoftDir 'shell.exe'

# ─── Helper functions ─────────────────────────────────────────────────────────

function Write-Step([string]$Msg) {
    Write-Host "  $Msg" -ForegroundColor Cyan
}

function Write-OK([string]$Msg) {
    Write-Host "  [OK] $Msg" -ForegroundColor Green
}

function Write-Skip([string]$Msg) {
    Write-Host "  [--] $Msg" -ForegroundColor Gray
}

function Abort([string]$Msg) {
    Write-Host "`n  [ERROR] $Msg" -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit 1
}

# ─── Header ───────────────────────────────────────────────────────────────────

Write-Host ''
Write-Host '  ╔════════════════════════════════════════╗' -ForegroundColor Magenta
Write-Host '  ║   FileConverter — Setup & Installer    ║' -ForegroundColor Magenta
Write-Host '  ╚════════════════════════════════════════╝' -ForegroundColor Magenta
Write-Host ''

# ─── Step 1: Check NileSoft Shell ─────────────────────────────────────────────

Write-Step 'Checking NileSoft Shell installation...'
if (-not (Test-Path $NilesoftNss)) {
    Abort "NileSoft Shell not found at: $NilesoftDir`nInstall NileSoft Shell first: https://nilesoft.org/download"
}
Write-OK "NileSoft Shell found at $NilesoftDir"

# ─── Step 2: Download FFmpeg (if needed) ──────────────────────────────────────

Write-Step 'Checking FFmpeg...'

if (Test-Path $FfmpegBin) {
    Write-Skip 'FFmpeg already installed, skipping download.'
} else {
    Write-Host '  Downloading portable FFmpeg from GitHub...' -ForegroundColor Yellow
    Write-Host '  (This is a one-time ~80MB download)' -ForegroundColor Gray

    # Get latest release info
    $ApiUrl  = 'https://api.github.com/repos/BtbN/FFmpeg-Builds/releases/latest'
    $Headers = @{ 'User-Agent' = 'FileConverter-Setup/1.0' }

    try {
        $Release = Invoke-RestMethod -Uri $ApiUrl -Headers $Headers -UseBasicParsing
    } catch {
        Abort "Failed to fetch FFmpeg release info: $_`n`nCheck your internet connection."
    }

    # Find the win64 essential build (smallest full build)
    $Asset = $Release.assets | Where-Object {
        $_.name -match 'ffmpeg-master-latest-win64-gpl\.zip$'
    } | Select-Object -First 1

    if (-not $Asset) {
        # Fallback: try any win64 zip
        $Asset = $Release.assets | Where-Object {
            $_.name -match 'win64.*\.zip$'
        } | Select-Object -First 1
    }

    if (-not $Asset) {
        Abort "Could not find a suitable FFmpeg Windows build in the latest release.`nPlease download manually from https://ffmpeg.org/download.html`nand extract to: $ToolsDir"
    }

    $ZipPath = Join-Path $env:TEMP 'ffmpeg_download.zip'
    $TmpDir  = Join-Path $env:TEMP 'ffmpeg_extract'

    Write-Host "  Downloading: $($Asset.name)" -ForegroundColor Gray
    Write-Host "  Size: $([math]::Round($Asset.size / 1MB, 1)) MB" -ForegroundColor Gray

    try {
        # Use WebClient for progress reporting
        $WebClient = New-Object System.Net.WebClient
        $WebClient.DownloadFile($Asset.browser_download_url, $ZipPath)
        Write-OK 'Download complete.'
    } catch {
        Abort "Download failed: $_"
    }

    # Extract
    Write-Host '  Extracting...' -ForegroundColor Yellow
    if (Test-Path $TmpDir) { Remove-Item $TmpDir -Recurse -Force }
    New-Item -ItemType Directory -Path $TmpDir -Force | Out-Null

    try {
        Expand-Archive -Path $ZipPath -DestinationPath $TmpDir -Force
    } catch {
        Abort "Extraction failed: $_"
    }

    # Find the inner folder (e.g. ffmpeg-master-latest-win64-gpl)
    $InnerDir = Get-ChildItem $TmpDir -Directory | Select-Object -First 1
    if (-not $InnerDir) {
        Abort "Unexpected archive structure. Please extract FFmpeg manually to: $ToolsDir"
    }

    # Move to ./tools/ffmpeg/
    if (Test-Path $ToolsDir) { Remove-Item $ToolsDir -Recurse -Force }
    New-Item -ItemType Directory -Path (Split-Path $ToolsDir -Parent) -Force | Out-Null
    Move-Item $InnerDir.FullName $ToolsDir -Force

    # Cleanup
    Remove-Item $ZipPath  -Force -ErrorAction SilentlyContinue
    Remove-Item $TmpDir   -Recurse -Force -ErrorAction SilentlyContinue

    if (-not (Test-Path $FfmpegBin)) {
        Abort "FFmpeg binary not found after extraction at: $FfmpegBin`nThe archive structure may have changed. Extract manually."
    }

    Write-OK "FFmpeg installed at: $FfmpegBin"
}

# ─── Step 3: Patch convert.ps1 with correct FFmpeg path ──────────────────────

Write-Step 'Verifying convert.ps1 FFmpeg path...'

$ConvertScript = Join-Path $ScriptDir 'convert.ps1'
if (-not (Test-Path $ConvertScript)) {
    Abort "convert.ps1 not found at $ConvertScript"
}
Write-OK 'convert.ps1 found.'

# ─── Step 4: Copy and patch file-converter.nss to NileSoft Shell imports ─────

Write-Step 'Installing and patching file-converter.nss into NileSoft Shell...'

if (-not (Test-Path $LocalNss)) {
    Abort "Local file-converter.nss not found at: $LocalNss"
}

try {
    # Dynamically patch the script path so it points to the user's current directory
    $ActualConvertPath = (Join-Path $ScriptDir 'convert.ps1').Replace('\', '/')
    $NssContent = Get-Content $LocalNss -Raw
    $PatchedNssContent = $NssContent -replace '(?<=-File ")[^"]*convert\.ps1', $ActualConvertPath
    
    Set-Content -Path $NilesoftImport -Value $PatchedNssContent -Encoding UTF8
    Write-OK "Installed and patched: $NilesoftImport (pointing to $ActualConvertPath)"
} catch {
    Abort "Failed to install/patch file-converter.nss (you may need to run as Administrator): $_"
}

# ─── Step 5: Add import line to shell.nss ─────────────────────────────────────

Write-Step "Patching shell.nss to import file-converter.nss..."

$ImportLine = "import 'imports/file-converter.nss'"
$NssContent = Get-Content $NilesoftNss -Raw

if ($NssContent -match [regex]::Escape($ImportLine)) {
    Write-Skip 'Import line already present in shell.nss.'
} else {
    # Append the import at the end of the file
    try {
        Add-Content -Path $NilesoftNss -Value "`r`n$ImportLine" -Encoding UTF8
        Write-OK 'Added import line to shell.nss.'
    } catch {
        Abort "Failed to write to shell.nss (you may need to run as Administrator): $_"
    }
}

# ─── Step 6: Restart NileSoft Shell ──────────────────────────────────────────

Write-Step 'Restarting NileSoft Shell to apply changes...'

try {
    & $NilesoftExe restart | Out-Null
    Start-Sleep -Milliseconds 800
    Write-OK 'NileSoft Shell restarted.'
} catch {
    Write-Host '  [WARN] Could not restart NileSoft Shell automatically.' -ForegroundColor Yellow
    Write-Host '         Please restart it manually: run shell.exe restart' -ForegroundColor Gray
}

# ─── Done ─────────────────────────────────────────────────────────────────────

Write-Host ''
Write-Host '  ╔════════════════════════════════════════╗' -ForegroundColor Green
Write-Host '  ║   Setup complete!                      ║' -ForegroundColor Green
Write-Host '  ╠════════════════════════════════════════╣' -ForegroundColor Green
Write-Host '  ║  Right-click a video, audio, or image  ║' -ForegroundColor Green
Write-Host '  ║  file in Explorer to see the new       ║' -ForegroundColor Green
Write-Host '  ║  "Convert Video/Audio/Image" menus.    ║' -ForegroundColor Green
Write-Host '  ╚════════════════════════════════════════╝' -ForegroundColor Green
Write-Host ''

Read-Host 'Press Enter to close'
