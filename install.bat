@echo off
title Installing Windows Disable New Desktop Blocker
echo ========================================================
echo   Windows Disable New Desktop (Win + Ctrl + D) Setup
echo ========================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
echo.
pause
