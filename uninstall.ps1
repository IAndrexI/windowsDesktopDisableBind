<#
.SYNOPSIS
    Uninstalls and stops the Win + Ctrl + D blocker.
.DESCRIPTION
    Stops running script instances, removes the Startup shortcut,
    and removes the AppData folder.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

Write-Host "==> Uninstalling Windows 'Disable New Desktop' Blocker..." -ForegroundColor Cyan

# 1. Terminate running process
$stopped = $false
Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*disable_new_desktop.ahk*" } | ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
    $stopped = $true
}
if ($stopped) {
    Write-Host "[+] Stopped running blocker process." -ForegroundColor Green
} else {
    Write-Host "[-] No running blocker process found." -ForegroundColor DarkGray
}

# 2. Remove Startup shortcut
$startupDir = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupDir "DisableNewDesktop.lnk"
if (Test-Path $shortcutPath) {
    Remove-Item -Path $shortcutPath -Force
    Write-Host "[+] Removed Startup shortcut: $shortcutPath" -ForegroundColor Green
}

# 3. Remove AppData directory
$appDir = "$env:LOCALAPPDATA\DisableNewDesktop"
if (Test-Path $appDir) {
    Remove-Item -Path $appDir -Recurse -Force
    Write-Host "[+] Removed AppData directory: $appDir" -ForegroundColor Green
}

Write-Host "==> Blocker successfully uninstalled. Win + Ctrl + D functionality restored." -ForegroundColor Cyan
