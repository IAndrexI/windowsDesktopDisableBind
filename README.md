# Windows Disable New Desktop (`Win + Ctrl + D`)

A lightweight, reliable background utility for Windows to intercept and suppress the **`Win + Ctrl + D`** hotkey that accidentally creates new virtual desktops.

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

## Step-by-Step Installation

### Method 1: Double-Click Installer (Easiest — No Commands Needed)

1. Open this project folder in **File Explorer**.
2. **Double-click `install.bat`**.
   - A command window will briefly open, check for AutoHotkey, set up the startup task, and start the blocker.
   - Press any key when prompted to close the window.

3. **Verify it is working**:
   - Check your Windows **System Tray** (near the clock, click the `^` arrow if hidden). You will see a green **H** icon with the tooltip:  
     `"Disable Win+Ctrl+D (Virtual Desktop)"`.
   - **Test**: Press `Win + Ctrl + D` — **no new desktop will be created**.
   - **Test**: Press `Win + D` — minimizing and showing the desktop still works as usual.

---

### Method 2: Via Windows Terminal or PowerShell

If you prefer using the command line:

1. In **File Explorer**, navigate to the project folder.
2. Open a terminal directly in this folder using either Windows shortcut:
   - Click the **address bar** at the top, type **`powershell`**, and press **Enter**.
   - *OR* Right-click any empty space in the folder and select **Open in Terminal**.
3. Run the installer:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

---

### Method 3: Manual Setup (No Scripts)

If you prefer to configure it yourself manually in Windows:

1. **Install AutoHotkey v2**:
   - Open PowerShell and run:
     ```powershell
     winget install --id AutoHotkey.AutoHotkey --scope user
     ```
   - *Or download the installer directly from [autohotkey.com](https://www.autohotkey.com/).*

2. **Copy the script to your AppData folder**:
   - Press `Win + R`, paste `%LOCALAPPDATA%`, and press **Enter**.
   - Create a folder named `DisableNewDesktop`.
   - Copy `disable_new_desktop.ahk` into `%LOCALAPPDATA%\DisableNewDesktop\`.

3. **Add to Windows Startup**:
   - Press `Win + R`, type `shell:startup`, and press **Enter**.
   - Right-click an empty area $\rightarrow$ **New** $\rightarrow$ **Shortcut**.
   - In *Type the location of the item*, enter:
     ```text
     "C:\Users\%USERNAME%\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe" "C:\Users\%USERNAME%\AppData\Local\DisableNewDesktop\disable_new_desktop.ahk"
     ```
   - Click **Next**, name it `DisableNewDesktop`, and click **Finish**.

4. **Start the Blocker**:
   - Double-click `disable_new_desktop.ahk` or the shortcut you just created.

---

## How to Manage or Pause the Blocker

You can manage the blocker at any time directly from the taskbar:

- **Temporarily pause**: Right-click the green **H** icon in the system tray and select **Suspend Hotkeys** (or **Pause Script**). `Win + Ctrl + D` will work again until you uncheck it.
- **Exit**: Right-click the **H** icon and select **Exit** (it will stay off until your next system boot).

---

## Step-by-Step Uninstallation

### Option A: Double-Click (Easiest)
1. In File Explorer, **double-click `uninstall.bat`**.
2. All running blocker processes are stopped, the startup shortcut is removed, and installed files are cleaned up.

### Option B: Via PowerShell
1. In the project folder, open PowerShell (address bar $\rightarrow$ type `powershell` $\rightarrow$ Enter).
2. Run:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
   ```

### Option C: Manual Removal
1. Press `Ctrl + Shift + Esc` to open **Task Manager**. Locate `AutoHotkey64`, right-click it, and click **End Task**.
2. Press `Win + R`, type `shell:startup`, and press **Enter**. Delete the `DisableNewDesktop.lnk` shortcut.
3. Press `Win + R`, paste `%LOCALAPPDATA%`, and delete the `DisableNewDesktop` folder.

---

## Troubleshooting & FAQ

#### 1. Did PowerToys already remap this shortcut?
- If you previously tried disabling `Win + Ctrl + D` using PowerToys:
  1. Open **PowerToys Settings**.
  2. Go to **Keyboard Manager** $\rightarrow$ **Remap a shortcut**.
  3. Delete the `Win + Ctrl + D` remap (trash icon) and click **OK**.
  *(AutoHotkey provides more reliable, low-level interception without modifier order bugs).*

#### 2. How do I close virtual desktops if I already created them?
- Press **`Win` + `Ctrl` + `F4`** to close the current virtual desktop and merge all open windows back to your primary desktop.
- Or press **`Win` + `Tab`** and click the `X` button on any extra desktop at the top/bottom.

---

## Project Structure

```text
├── disable_new_desktop.ahk   # Core AutoHotkey v2 hook script
├── install.bat               # One-click Windows batch installer
├── install.ps1               # Automated installer & startup registration
├── uninstall.bat             # One-click Windows batch uninstaller
├── uninstall.ps1             # Clean uninstaller
├── LICENSE                   # MIT License
└── README.md                 # Documentation and step-by-step guide
```

## System Requirements

- **Operating System**: Windows 10 or Windows 11 (64-bit or 32-bit)
- **Dependencies**: AutoHotkey v2.0+ (automatically installed by `install.bat` / `install.ps1`)
- **Privileges**: Standard user permissions (no Administrator/UAC prompt needed)

## License

This project is licensed under the [MIT License](LICENSE).
