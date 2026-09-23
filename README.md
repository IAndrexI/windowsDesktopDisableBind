# Windows Disable New Desktop (`Win + Ctrl + D`)

A lightweight background utility for Windows to disable the **`Win + Ctrl + D`** shortcut that creates new virtual desktops.

---

## Step-by-Step Installation

### Method 1: Double-Click Installer (Recommended)

1. Open this project folder in **File Explorer**.
2. **Double-click `install.bat`**.
   - A command window will briefly open, install AutoHotkey v2 (if not already installed), configure Windows Startup, and start the blocker.
   - Press any key when prompted to finish.

3. **Verify it is working**:
   - Check your Windows **System Tray** (near the clock, click the `^` arrow if hidden). You will see a green **H** icon with the tooltip:  
     `"Disable Win+Ctrl+D (Virtual Desktop)"`.
   - **Test**: Press `Win + Ctrl + D` — no new desktop will be created.
   - **Test**: Press `Win + D` — showing/minimizing the desktop continues to work normally.

---

### Method 2: Via Windows Terminal or PowerShell

1. Open this project folder in **File Explorer**.
2. Click the folder's **address bar** at the top, type **`powershell`**, and press **Enter** (opens PowerShell directly in the current directory).
3. Run the installer script:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```

---

### Method 3: Manual Setup (Without Scripts)

1. **Install AutoHotkey v2**:
   - Open PowerShell and run:
     ```powershell
     winget install --id AutoHotkey.AutoHotkey --scope user
     ```
   - *(Or download the installer from [autohotkey.com](https://www.autohotkey.com/))*

2. **Copy the script to your AppData folder**:
   - Press `Win + R`, paste `%LOCALAPPDATA%`, and press **Enter**.
   - Create a folder named `DisableNewDesktop`.
   - Copy `disable_new_desktop.ahk` into `%LOCALAPPDATA%\DisableNewDesktop\`.

3. **Add to Windows Startup**:
   - Press `Win + R`, type `shell:startup`, and press **Enter**.
   - Right-click an empty area $\rightarrow$ **New** $\rightarrow$ **Shortcut**.
   - Under *Type the location of the item*, enter:
     ```text
     "C:\Users\%USERNAME%\AppData\Local\Programs\AutoHotkey\v2\AutoHotkey64.exe" "C:\Users\%USERNAME%\AppData\Local\DisableNewDesktop\disable_new_desktop.ahk"
     ```
   - Click **Next**, name the shortcut `DisableNewDesktop`, and click **Finish**.

4. **Start the Blocker**:
   - Double-click the newly created shortcut or double-click `disable_new_desktop.ahk`.

---

## Managing or Pausing

- **Temporarily Pause**: Right-click the green **H** icon in the system tray and select **Suspend Hotkeys** (or **Pause Script**). `Win + Ctrl + D` will work again until unpaused.
- **Exit**: Right-click the **H** icon and select **Exit** (stays off until your next Windows login).

---

## Step-by-Step Uninstallation

### Option A: Double-Click Uninstaller (Recommended)
1. Open this project folder in **File Explorer**.
2. **Double-click `uninstall.bat`**.
   - Stops the running background process, removes the Windows Startup shortcut, and deletes the installed files.

### Option B: Via PowerShell
1. In the project folder, click the address bar, type `powershell`, and press **Enter**.
2. Run:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
   ```

### Option C: Manual Removal
1. Press `Ctrl + Shift + Esc` to open **Task Manager**. Locate `AutoHotkey64`, right-click it, and select **End Task**.
2. Press `Win + R`, type `shell:startup`, and press **Enter**. Delete the `DisableNewDesktop.lnk` shortcut.
3. Press `Win + R`, paste `%LOCALAPPDATA%`, and delete the `DisableNewDesktop` folder.

---

## Project Structure

```text
├── disable_new_desktop.ahk   # Core AutoHotkey v2 hook script
├── install.bat               # One-click Windows batch installer
├── install.ps1               # Automated installer & startup registration
├── uninstall.bat             # One-click Windows batch uninstaller
├── uninstall.ps1             # Clean uninstaller
├── LICENSE                   # MIT License
└── README.md                 # Step-by-step documentation
```

## System Requirements

- **Operating System**: Windows 10 or Windows 11 (64-bit or 32-bit)
- **Dependencies**: AutoHotkey v2.0+ (automatically installed by `install.bat` / `install.ps1`)
- **Privileges**: Standard user permissions (no Administrator required)

## License

This project is licensed under the [MIT License](LICENSE).
