;================================================================
; AutoHotkey v2 – “smart toggle” launcher set
; • Press the hotkey once → bring app to front (or launch it)
; • Press again → minimise it
; • Works whether the app was normal-sized or maximised
; ================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force ; replace the running script on reload

; Disable Caps key, and remap it as Ctrl
SetCapsLockState "AlwaysOff"
CapsLock::Ctrl

;--------------------------------------------------
; Helper: ToggleApp()
; id – any WinTitle string (ahk_exe, ahk_class, etc.)
; runPath – command or full path to launch when not running
;--------------------------------------------------
ToggleApp(id, runPath) {
    hwnd := WinExist(id)
    if !hwnd { ; ── 1) not running → start it
        Run runPath
        return
    }

    if WinActive("ahk_id " hwnd)
        WinMinimize hwnd ; ── 2) already foreground → hide it
    else
        WinActivate hwnd ; ── 3) background / minimised → front (restores if needed)
}

; ─────────── Browser (Ctrl + Alt + F) ───────────
^!f:: ToggleApp("ahk_exe chrome.exe"
, "C:\Program Files\Google\Chrome\Application\chrome.exe")
;^!f:: ToggleApp("ahk_exe msedge.exe"
;, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")

; ─────────── Windows Terminal / Cmd (Ctrl + Alt + R) ───────────
; • Keep the id below for Windows Terminal, or change to
; "ahk_class ConsoleWindowClass" if you prefer classic cmd.exe
^!r:: ToggleApp("ahk_exe WindowsTerminal.exe", "cmd.exe")

; ─────────── Notepad (Ctrl + Alt + G) ───────────
;^!t:: ToggleApp("ahk_exe Notepad.exe", "notepad.exe")
;^!g:: ToggleApp("ahk_exe Notepad--.exe", "C:\Program Files\Notepad--\Notepad--.exe")
^!g:: ToggleApp("ahk_exe notepad++.exe", "C:\Program Files\Notepad++\notepad++.exe")


; ─────────── File Explorer (Ctrl + Alt + K) ───────────
^!k:: ToggleApp("ahk_class CabinetWClass", "explorer.exe")

; ─────────── Obsidian (Ctrl + Alt + E) ───────────
^!e:: ToggleApp("ahk_exe Obsidian.exe"
, "C:\Users\ross\AppData\Local\Programs\Obsidian\Obsidian.exe")

; ─────────── VS Code (Ctrl + Alt + P) ───────────
^!p:: ToggleApp("ahk_exe Code.exe"
, "C:\Users\ross\AppData\Local\Programs\Microsoft VS Code\Code.exe")

; ─────────── WPS (Ctrl + Alt + W) ───────────
;^!w:: ToggleApp("ahk_exe wps.exe", "C:\Users\ross\AppData\Local\Kingsoft\WPS Office\12.1.0.25225\office6\wps.exe")

; ─────────── Workspace (Ctrl + Alt + W) ───────────
; I use pycharm very often, so I set ctrl+alt+w to Pycharm (workspace)
^!w:: ToggleApp("ahk_exe pycharm64.exe", "C:\Program Files\JetBrains\PyCharm 2023.3.5\bin\pycharm64.exe")



; ─────────── Chatbox/Dbeaver (Ctrl + Alt + D) ───────────
;^!d:: ToggleApp("ahk_exe Chatbox.exe", "C:\Users\ross\AppData\Local\Programs\Chatbox\Chatbox.exe")

^!i:: ToggleApp("ahk_exe dbeaver.exe", "C:\Users\ross\AppData\Local\DBeaver\dbeaver.exe")

; ─────────── Chatbox/Dbeaver (Ctrl + Alt + I) ───────────
^!d:: ToggleApp("ahk_exe Chatbox.exe", "C:\Users\ross\AppData\Local\Programs\Chatbox\Chatbox.exe")


; ─────────── Chatbox/Dbeaver (Ctrl + Alt + T) ───────────
^!t:: ToggleApp("ahk_exe Typora.exe", "D:\develop\soft\Typora\Typora.exe")


; Ctrl + M → maximise the active window
^m:: WinMaximize "A" ; "A" = the active (foreground) window


; Use Alt+Q to quit the program (by sending Alt + F4 instead)
!q::Send "!{F4}"

;PrintScreen::NumLock
; 把 PrintScreen 映射成 Ctrl+Shift+4 实现截图的功能
PrintScreen::^+4

Pause::Delete
Insert::Delete

; map alt+w to ctrl+w
<!w::Send "^w"   ; left-alt + w only (won't trigger when Ctrl is also down)

#!c::^c
!v::^v
!x::^x
!z::^z


; Now when Ctrl gets “stuck”, press Ctrl+Alt+Backspace once and it should immediately recover.
^!Backspace:: {
    Send "{Ctrl up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}{Shift up}{LShift up}{RShift up}{LWin up}{RWin up}"
    TrayTip "AHK", "Released stuck modifier keys with: Ctrl+Alt+Backspace", 2
}

; Release modifiers automatically when the script exits/reloads
OnExit(ExitCleanup)

ExitCleanup(ExitReason, ExitCode) {
    Send "{Ctrl up}{LControl up}{RControl up}{Alt up}{LAlt up}{RAlt up}{Shift up}{LShift up}{RShift up}{LWin up}{RWin up}"
}


; WPS pdf 快捷键设置

#HotIf WinActive("ahk_exe wps.exe")
^g::Send("^{3}")
^t::Send("!{r}")
#HotIf

; reload the auto-script configuration
;^!+r::Reload   ; Ctrl+Alt+Shift+R
^!+r:: {
    TrayTip "AHK", "Reloading script...with Ctrl+Alt+Shift+R", 2
    Reload
}