<#
.SYNOPSIS
    FileConverter - Universal media converter powered by FFmpeg.
#>
param(
    [string] $InputPath = '',
    [string] $Preset    = ''
)

$ErrorActionPreference = 'Continue'
$LogFile = "$env:TEMP\FileConverter.log"

function Write-Log([string]$Msg) {
    $line = "$(Get-Date -Format 'HH:mm:ss')  $Msg"
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}

function Fatal([string]$Msg) {
    Write-Log "FATAL: $Msg"
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show($Msg, 'FileConverter - Error',
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit 1
}

function Info([string]$Msg) {
    Write-Log "INFO: $Msg"
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show($Msg, 'FileConverter',
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null
}

# Start log
"" | Set-Content $LogFile -Encoding UTF8
Write-Log "=== FileConverter started ==="
Write-Log "InputPath = [$InputPath]"
Write-Log "Preset    = [$Preset]"

# Basic validation
if ($InputPath -eq '') { Fatal "No -InputPath provided." }
if ($Preset    -eq '') { Fatal "No -Preset provided." }

# Paths
$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$FfmpegPath  = Join-Path $ScriptDir 'tools\ffmpeg\bin\ffmpeg.exe'
$PresetsFile = Join-Path $ScriptDir 'presets.json'

Write-Log "ScriptDir   = $ScriptDir"
Write-Log "FfmpegPath  = $FfmpegPath"
Write-Log "PresetsFile = $PresetsFile"

if (-not (Test-Path $FfmpegPath)) {
    Fatal "FFmpeg not found at:`n$FfmpegPath`n`nRun setup.ps1 first."
}
if (-not (Test-Path $PresetsFile)) {
    Fatal "presets.json not found at:`n$PresetsFile"
}

# Load presets
try {
    $Presets = (Get-Content $PresetsFile -Raw -Encoding UTF8) | ConvertFrom-Json
} catch {
    Fatal "Failed to read presets.json:`n$_"
}

if ($null -eq $Presets.presets.$Preset) {
    Fatal "Unknown preset: '$Preset'`n`nValid presets are listed in presets.json."
}

$Def    = $Presets.presets.$Preset
$OutExt = $Def.ext
$ExtraArgs = @()
if ($Def.args -ne $null) {
    foreach ($a in $Def.args) { $ExtraArgs += $a }
}
Write-Log "Preset def: ext=$OutExt  args=$($ExtraArgs -join ' ')"

# Split multi-file input (paths joined by * from NSS)
$AllFiles = @($InputPath -split '\*' | Where-Object { $_.Trim() -ne '' })
Write-Log "File count: $($AllFiles.Count)"
foreach ($f in $AllFiles) { Write-Log "  File: $f" }

Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.Drawing       -ErrorAction SilentlyContinue

$ThreadCount = [Math]::Max(1, [int]($env:NUMBER_OF_PROCESSORS / 2))
Write-Log "CPU Thread limit set to: $ThreadCount"

$OK   = [System.Collections.Generic.List[string]]::new()
$Fail = [System.Collections.Generic.List[string]]::new()
$i    = 0

foreach ($SrcPath in $AllFiles) {
    $i++
    $SrcPath = $SrcPath.Trim()

    if (-not (Test-Path -LiteralPath $SrcPath)) {
        Write-Log "SKIP: not found - $SrcPath"
        $Fail.Add("Not found: $SrcPath")
        continue
    }

    $Item    = Get-Item -LiteralPath $SrcPath
    $OutName = "$($Item.BaseName)_converted.$OutExt"
    $DstPath = Join-Path $Item.DirectoryName $OutName

    # Avoid overwriting source
    if ($DstPath -ieq $SrcPath) { $OutName = "$($Item.BaseName)_out.$OutExt"; $DstPath = Join-Path $Item.DirectoryName $OutName }

    # Avoid overwriting existing output
    $n = 2
    while (Test-Path -LiteralPath $DstPath) {
        $OutName = "$($Item.BaseName)_converted_$n.$OutExt"
        $DstPath = Join-Path $Item.DirectoryName $OutName
        $n++
    }

    Write-Log "Converting [$i/$($AllFiles.Count)]: $SrcPath -> $DstPath"

    $CmdArgs = @('-y', '-threads', $ThreadCount.ToString(), '-i', "`"$SrcPath`"") + $ExtraArgs + @("`"$DstPath`"")
    Write-Log "ffmpeg args: $($CmdArgs -join ' ')"

    try {
        $ErrFile = "$env:TEMP\fc_err.txt"
        $p = Start-Process -FilePath $FfmpegPath `
                           -ArgumentList $CmdArgs `
                           -Wait -PassThru `
                           -WindowStyle Hidden `
                           -RedirectStandardError $ErrFile

        Write-Log "ffmpeg exit code: $($p.ExitCode)"

        if ($p.ExitCode -ne 0) {
            $errTxt = if (Test-Path $ErrFile) { Get-Content $ErrFile -Raw } else { '' }
            
            # If the error is due to NVENC or missing/outdated GPU driver, fall back to CPU
            if ($errTxt -match 'driver|nvenc|function not implemented|no nvenc|not supported|failed to create' -and ($ExtraArgs -contains 'h264_nvenc' -or $ExtraArgs -contains 'hevc_nvenc' -or $ExtraArgs -contains 'av1_nvenc')) {
                Write-Log "GPU encoder failed due to driver/hardware limitations. Retrying with CPU (fallback)..."
                
                $CpuArgs = @()
                for ($j = 0; $j -lt $ExtraArgs.Count; $j++) {
                    if ($ExtraArgs[$j] -eq 'h264_nvenc') {
                        $CpuArgs += 'libx264'
                    }
                    elseif ($ExtraArgs[$j] -eq 'hevc_nvenc') {
                        $CpuArgs += 'libx265'
                    }
                    elseif ($ExtraArgs[$j] -eq 'av1_nvenc') {
                        $CpuArgs += 'libsvtav1'
                    }
                    elseif ($ExtraArgs[$j] -eq '-rc' -and $ExtraArgs[$j+1] -eq 'vbr') {
                        $j++ # Skip '-rc vbr'
                    }
                    elseif ($ExtraArgs[$j] -eq '-cq') {
                        $CpuArgs += '-crf'
                    }
                    elseif ($ExtraArgs[$j] -eq '-preset' -and $ExtraArgs[$j+1] -like 'p*') {
                        # Map NVENC p1-p7 presets to CPU presets
                        $nvPreset = $ExtraArgs[$j+1]
                        $isAv1 = $CpuArgs -contains 'libsvtav1'
                        if ($isAv1) {
                            $cpuPreset = '6'
                            if ($nvPreset -eq 'p1' -or $nvPreset -eq 'p2') { $cpuPreset = '8' }
                            elseif ($nvPreset -eq 'p5' -or $nvPreset -eq 'p6' -or $nvPreset -eq 'p7') { $cpuPreset = '4' }
                        } else {
                            $cpuPreset = 'medium'
                            if ($nvPreset -eq 'p1' -or $nvPreset -eq 'p2') { $cpuPreset = 'fast' }
                            elseif ($nvPreset -eq 'p5' -or $nvPreset -eq 'p6' -or $nvPreset -eq 'p7') { $cpuPreset = 'slow' }
                        }
                        $CpuArgs += @('-preset', $cpuPreset)
                        $j++
                    }
                    else {
                        $CpuArgs += $ExtraArgs[$j]
                    }
                }
                
                $CmdArgs = @('-y', '-threads', $ThreadCount.ToString(), '-i', "`"$SrcPath`"") + $CpuArgs + @("`"$DstPath`"")
                Write-Log "Retrying with CPU arguments: $($CmdArgs -join ' ')"
                
                $p = Start-Process -FilePath $FfmpegPath `
                                   -ArgumentList $CmdArgs `
                                   -Wait -PassThru `
                                   -WindowStyle Hidden `
                                   -RedirectStandardError $ErrFile
                
                Write-Log "Fallback ffmpeg exit code: $($p.ExitCode)"
            }
        }

        if ($p.ExitCode -eq 0) {
            $OK.Add($DstPath)
        } else {
            $errTxt = if (Test-Path $ErrFile) { Get-Content $ErrFile -Raw } else { '' }
            $lastLine = $errTxt.Split("`n") | Where-Object { $_.Trim() -ne '' } | Select-Object -Last 1
            Write-Log "ffmpeg ERROR: $lastLine"
            $Fail.Add("$($Item.Name): exit $($p.ExitCode)`n$lastLine")
        }
    } catch {
        Write-Log "Exception: $_"
        $Fail.Add("$($Item.Name): $_")
    }
}

Write-Log "Done. OK=$($OK.Count)  Fail=$($Fail.Count)"
Write-Log "Log saved to: $LogFile"

if ($Fail.Count -eq 0) {
    $msg = if ($OK.Count -eq 1) { "Done!`n`nSaved as:`n$($OK[0])" } `
           else { "Converted $($OK.Count) files.`n`nFiles saved next to originals." }
    Info $msg
} else {
    $ok_line  = if ($OK.Count -gt 0)  { "OK: $($OK.Count)`n" } else { '' }
    $err_line = $Fail -join "`n`n"
    Fatal "${ok_line}Failed $($Fail.Count):`n`n$err_line`n`nSee log: $LogFile"
}
