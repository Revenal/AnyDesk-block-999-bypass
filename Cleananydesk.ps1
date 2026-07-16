# 1. Clean up files causing error 999
$AppDataPath = “$env:APPDATA\AnyDesk”
$LocalPath = “$env:LOCALAPPDATA\AnyDesk”

# Close AnyDesk if it has hung
Stop-Process -Name “AnyDesk*” -Force -ErrorAction SilentlyContinue

if (Test-Path $AppDataPath) {
    Remove-Item -Path “$AppDataPath\service.conf” -Force -ErrorAction SilentlyContinue
    Remove-Item -Path “$AppDataPath\system.conf” -Force -ErrorAction SilentlyContinue
}

if (Test-Path $LocalPath) {
    Remove-Item -Path $LocalPath -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Generic AnyDesk startup
# Searches common locations
$PossiblePaths = @(
    “$env:ProgramFiles(x86)\AnyDesk\AnyDesk.exe”,
    “$env:ProgramFiles\AnyDesk\AnyDesk.exe”,
    “$env:USERPROFILE\Desktop\AnyDesk.exe”,
    “$env:USERPROFILE\Downloads\AnyDesk.exe”
)

$AnyDeskExe = $null

foreach ($Path in $PossiblePaths) {
    if (Test-Path $Path) {
        $AnyDeskExe = $Path
        break
    }
}

# If not found, ask the user for the location
if (-not $AnyDeskExe) {
    $AnyDeskExe = Read-Host "AnyDesk was not found automatically. Paste the full path to the executable here (e.g., C:\Folder\AnyDesk.exe)"
}

if (Test-Path $AnyDeskExe) {
    Start-Process -FilePath $AnyDeskExe
} else {
    Write-Host “Error: Invalid path.” -ForegroundColor Red
    Pause
}
