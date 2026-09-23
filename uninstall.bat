@echo off
title Uninstalling Windows Disable New Desktop Blocker
echo ========================================================
echo   Windows Disable New Desktop (Win + Ctrl + D) Uninstall
echo ========================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1"
echo.
pause
