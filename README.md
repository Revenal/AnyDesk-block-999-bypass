# AnyDesk-block-999-bypass
PowerShell script to forcefully delete AnyDesk's local configuration and cache files in order to bypass restriction errors that caused users to wait for 999 seconds. Includes automatic process termination and restart logic.

## How to use it
1. Download `Cleananydesk.ps1` to your PC.
2. Create a shortcut on your desktop:
   - Right-click on the desktop > New > Shortcut.
   - In the “Target” field, enter: `powershell.exe -ExecutionPolicy Bypass -File “C:\path\to\your\script\Cleananydesk.ps1”`
   - This command allows you to run the script via PowerShell while bypassing execution restrictions.

