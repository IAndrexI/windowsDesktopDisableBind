# Windows Disable New Desktop (`Win + Ctrl + D`)

A lightweight, reliable utility to intercept and suppress the Windows **`Win + Ctrl + D`** shortcut that creates new virtual desktops.

## The Problem

In Windows 10 and 11, pressing `Win + Ctrl + D` instantly creates a new virtual desktop. Users frequently trigger this by accident when intending to press `Win + D` (show desktop) or `Ctrl + D`.

While tools like Microsoft PowerToys attempt to remap or disable this shortcut, it often fails because:
- PowerToys requires strict modifier ordering or exact key codes (`VK_LWIN` vs `VK_RWIN`, `VK_LCONTROL` vs `VK_RCONTROL`).
- Windows shell hotkeys are processed at a low level that PowerToys frequently misses or conflicts with.

## The Solution

This utility uses **AutoHotkey v2** with a low-level keyboard hook (`*^#d::return`). It captures any combination of `Ctrl` and `Win` keys pressed together with `D` regardless of order or left/right distinction, and drops the event before Windows Shell / Virtual Desktop Manager can see it.

## Quick Start (Installation)

Open PowerShell and run:

```powershell
.\install.ps1
```

### What `install.ps1` does:
1. Verifies **AutoHotkey v2** is installed (installs it automatically via `winget` if missing).
2. Copies `disable_new_desktop.ahk` to `%LOCALAPPDATA%\DisableNewDesktop`.
3. Sets up a shortcut in Windows Startup (`shell:startup`) so it runs automatically in the background on system boot.
4. Starts the blocker process immediately.

## Uninstallation

To restore the default Windows shortcut, run:

```powershell
.\uninstall.ps1
```

This stops the background process, deletes the Startup shortcut, and removes all installed files.

## Project Structure

```text
├── disable_new_desktop.ahk   # Core AutoHotkey v2 hook script
├── install.ps1               # Automated installer & startup registration
├── uninstall.ps1             # Clean uninstaller
├── LICENSE                   # MIT License
└── README.md                 # Project documentation
```

## Requirements

- Windows 10 or Windows 11
- AutoHotkey v2.0+ (automatically installed by `install.ps1` via `winget`)
- PowerShell 5.1+

## License

[MIT](LICENSE)
