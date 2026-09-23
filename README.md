# Windows Disable New Desktop (`Win + Ctrl + D`)

A lightweight, reliable background utility to intercept and suppress the Windows **`Win + Ctrl + D`** hotkey that accidentally creates new virtual desktops.

---

## The Problem

In Windows 10 and 11, pressing `Win + Ctrl + D` instantly creates a new virtual desktop. Users frequently trigger this by mistake when trying to press `Win + D` (show desktop) or `Ctrl + D` (bookmark/delete).

While utilities like Microsoft PowerToys attempt to remap or disable this shortcut:
- PowerToys requires strict modifier ordering or exact key codes (`VK_LWIN` vs `VK_RWIN`, `VK_LCONTROL` vs `VK_RCONTROL`).
- PowerToys often fails to block Windows Shell hotkeys that are registered at a lower system level.

---

## The Solution

This utility uses **AutoHotkey v2** with a low-level keyboard hook (`*^#d::return`). 
- **Wildcard modifier (`*`)**: Intercepts `Ctrl` and `Win` regardless of whether you press Left or Right keys, or which key you press down first.
- **Suppression (`return`)**: Swallows the keystroke so the Windows Virtual Desktop Manager never receives the `D` event.
- **No side-effects**: Other standard shortcuts like `Win + D`, `Ctrl + D`, and `Win + Tab` continue to function normally.

---

## Detailed Step-by-Step Installation

### Method 1: Automated Installation via PowerShell (Recommended)

1. **Open PowerShell**:
   - Press `Win + X` and select **Terminal** or **PowerShell** (no Administrator privileges required).

2. **Navigate to the repository folder**:
   ```powershell
   cd "path\to\windowsDesktopDisableBind"
   ```

3. **Run the installation script**:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```
   > **Note:** The `-ExecutionPolicy Bypass` flag ensures Windows allows the script to run even if your system has restrictive script policies enabled.

4. **Verify the installation**:
   - Look in your Windows **System Tray** (near the clock, click the `^` arrow if hidden). You should see a green **H** icon with the tooltip:  
     `"Disable Win+Ctrl+D (Virtual Desktop)"`.
   - **Test the shortcut**: Press `Win + Ctrl + D`. Notice that **no new desktop is created**.
   - **Test standard shortcuts**: Press `Win + D` to verify that minimizing/showing the desktop still works.

---

### Method 2: Manual Installation (Without Running Scripts)

If you prefer to configure it manually without running `.ps1` scripts:

1. **Install AutoHotkey v2**:
   - Run in PowerShell:
     ```powershell
     winget install --id AutoHotkey.AutoHotkey --scope user
     ```
   - *Alternatively, download and run the installer from [autohotkey.com](https://www.autohotkey.com/).*

2. **Create the application folder**:
   - Press `Win + R`, paste `%LOCALAPPDATA%`, and press **Enter**.
   - Create a new folder named `DisableNewDesktop`.
   - Copy `disable_new_desktop.ahk` into `%LOCALAPPDATA%\DisableNewDesktop\`.

3. **Add to Windows Startup**:
   - Press `Win + R`, type `shell:startup`, and press **Enter** (opens your Startup folder).
   - Right-click an empty space $\rightarrow$ **New** $\rightarrow$ **Shortcut**.
   - Under *Type the location of the item*, enter:
     ```text
     "C:\Users\%USERNAME%\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe" "C:\Users\%USERNAME%\AppData\Local\DisableNewDesktop\disable_new_desktop.ahk"
     ```
   - Click **Next**, name the shortcut `DisableNewDesktop`, and click **Finish**.

4. **Start the Blocker**:
   - Double-click the newly created shortcut or double-click `disable_new_desktop.ahk`.

---

## How to Manage or Pause the Blocker

You can manage the blocker at any time directly from the taskbar:

- **Temporarily pause**: Right-click the green **H** icon in the system tray and select **Suspend Hotkeys** (or **Pause Script**). `Win + Ctrl + D` will work again until you uncheck it.
- **Exit**: Right-click the **H** icon and select **Exit** (it will stay off until your next system boot).

---

## Detailed Step-by-Step Uninstallation

### Option A: Using the Uninstaller Script
1. Open PowerShell in this project folder.
2. Run:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
   ```
3. The process is terminated, the startup shortcut is removed, and all files in `%LOCALAPPDATA%\DisableNewDesktop` are cleaned up.

### Option B: Manual Removal
1. Press `Ctrl + Shift + Esc` to open **Task Manager**. Locate `AutoHotkey64` (or `AutoHotkey`), right-click it, and select **End Task**.
2. Press `Win + R`, type `shell:startup`, and press **Enter**. Delete the `DisableNewDesktop.lnk` shortcut.
3. Press `Win + R`, paste `%LOCALAPPDATA%`, and delete the `DisableNewDesktop` folder.

---

## Troubleshooting & FAQ

#### 1. "File ...\install.ps1 cannot be loaded because running scripts is disabled on this system"
- Windows restricts `.ps1` scripts by default. To bypass this for this single run without changing global system security:
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\install.ps1
  ```

#### 2. Did PowerToys already remap this shortcut?
- If you previously configured PowerToys Keyboard Manager to disable `Win + Ctrl + D`:
  1. Open **PowerToys Settings**.
  2. Navigate to **Keyboard Manager** $\rightarrow$ **Remap a shortcut**.
  3. Delete the existing `Win + Ctrl + D` entry (click the trash can icon) and save with **OK**.
  *(AutoHotkey provides lower-level and more reliable interception than PowerToys).*

#### 3. How do I close virtual desktops if I already created them?
- Press **`Win` + `Ctrl` + `F4`** to close the current active virtual desktop and move all open windows back to your primary desktop.
- Or press **`Win` + `Tab`** and click the `X` button on any extra desktop at the top/bottom.

---

## Project Structure

```text
├── disable_new_desktop.ahk   # Core AutoHotkey v2 hook script
├── install.ps1               # Automated installer & startup registration
├── uninstall.ps1             # Clean uninstaller
├── LICENSE                   # MIT License
└── README.md                 # Detailed documentation and step-by-step guide
```

## System Requirements

- **Operating System**: Windows 10 or Windows 11 (64-bit or 32-bit)
- **Dependencies**: AutoHotkey v2.0+ (automatically installed by `install.ps1`)
- **Privileges**: Standard user permissions (no Administrator/UAC prompt needed)

## License

This project is licensed under the [MIT License](LICENSE).
