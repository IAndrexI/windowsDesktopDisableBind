#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; Disable New Virtual Desktop Shortcut (Win + Ctrl + D)
; ==============================================================================
; Windows creates a new virtual desktop when pressing Win + Ctrl + D.
; This script installs a low-level keyboard hook that intercepts this shortcut
; and suppresses the key event before the Windows shell can handle it.
;
; Features:
; - Wildcard (*) modifier matches any combination of Left/Right Win and Ctrl keys
; - Independent of the sequence keys are pressed
; - Lightweight and runs silently in the background
; ==============================================================================

A_IconTip := "Disable Win+Ctrl+D (Virtual Desktop)"

; Block Win + Ctrl + D
*^#d::return
