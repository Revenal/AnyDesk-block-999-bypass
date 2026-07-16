# 1. Pulizia chirurgica dei file che causano il blocco 999
$AppDataPath = "$env:APPDATA\AnyDesk"
$LocalPath = "$env:LOCALAPPDATA\AnyDesk"

# Chiude AnyDesk se è rimasto appeso
Stop-Process -Name "AnyDesk*" -Force -ErrorAction SilentlyContinue

if (Test-Path $AppDataPath) {
    Remove-Item -Path "$AppDataPath\service.conf" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$AppDataPath\system.conf" -Force -ErrorAction SilentlyContinue
}

if (Test-Path $LocalPath) {
    Remove-Item -Path $LocalPath -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Avvio di AnyDesk generico
# Cerca in alcuni percorsi comuni
$PossiblePaths = @(
    "$env:ProgramFiles(x86)\AnyDesk\AnyDesk.exe",
    "$env:ProgramFiles\AnyDesk\AnyDesk.exe",
    "$env:USERPROFILE\Desktop\AnyDesk.exe",
    "$env:USERPROFILE\Downloads\AnyDesk.exe"
)

$AnyDeskExe = $null

foreach ($Path in $PossiblePaths) {
    if (Test-Path $Path) {
        $AnyDeskExe = $Path
        break
    }
}

# Se non trovato, chiede all'utente dove si trova
if (-not $AnyDeskExe) {
    $AnyDeskExe = Read-Host "AnyDesk non trovato automaticamente. Incolla qui il percorso completo dell'eseguibile (es. C:\Cartella\AnyDesk.exe)"
}

if (Test-Path $AnyDeskExe) {
    Start-Process -FilePath $AnyDeskExe
} else {
    Write-Host "Errore: Percorso non valido." -ForegroundColor Red
    Pause
}
