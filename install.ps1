<#
.SYNOPSIS
    Installs and activates the Win + Ctrl + D blocker.
.DESCRIPTION
    Ensures AutoHotkey v2 is installed, copies the script to AppData,
    creates a Startup shortcut, and starts the blocker immediately.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

Write-Host "==> Installing Windows 'Disable New Desktop' Blocker..." -ForegroundColor Cyan

# 1. Locate AutoHotkey v2
$ahkExe = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
if (-not (Test-Path $ahkExe)) {
    $ahkExe = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"
}

if (-not (Test-Path $ahkExe)) {
    Write-Host "[*] AutoHotkey v2 not found. Installing via winget..." -ForegroundColor Yellow
    try {
        winget install --id AutoHotkey.AutoHotkey --scope user --silent --accept-package-agreements --accept-source-agreements
        $ahkExe = "$env:LOCALAPPDATA\Programs\AutoHotkey\v2\AutoHotkey64.exe"
    } catch {
        Write-Error "Failed to install AutoHotkey automatically. Please install AutoHotkey v2 manually from https://www.autohotkey.com/."
    }
}

if (-not (Test-Path $ahkExe)) {
    Write-Error "AutoHotkey v2 executable not found at '$ahkExe'."
}

Write-Host "[+] Found AutoHotkey v2: $ahkExe" -ForegroundColor Green

# 2. Setup AppData directory and copy script
$appDir = "$env:LOCALAPPDATA\DisableNewDesktop"
if (-not (Test-Path $appDir)) {
    New-Item -ItemType Directory -Path $appDir -Force | Out-Null
}

$sourceScript = Join-Path $PSScriptRoot "disable_new_desktop.ahk"
$targetScript = Join-Path $appDir "disable_new_desktop.ahk"
Copy-Item -Path $sourceScript -Destination $targetScript -Force
Write-Host "[+] Copied script to $targetScript" -ForegroundColor Green

# 3. Create shortcut in Windows Startup
$startupDir = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupDir "DisableNewDesktop.lnk"

$wshShell = New-Object -ComObject WScript.Shell
$shortcut = $wshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $ahkExe
$shortcut.Arguments = "`"$targetScript`""
$shortcut.WorkingDirectory = $appDir
$shortcut.Description = "Blocks Win + Ctrl + D from creating new virtual desktops"
$shortcut.Save()
Write-Host "[+] Created Startup shortcut at $shortcutPath" -ForegroundColor Green

# 4. Stop existing instance if running and launch new instance
Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*disable_new_desktop.ahk*" } | ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Start-Process -FilePath $ahkExe -ArgumentList "`"$targetScript`""
Write-Host "[+] Blocker is running in the background!" -ForegroundColor Green
Write-Host "==> Done! Win + Ctrl + D is now disabled." -ForegroundColor Cyan
