# 1. Pulizia chirurgica dei file che causano il blocco 999
$AppDataPath = "$env:APPDATA\AnyDesk"
$LocalPath = "$env:LOCALAPPDATA\AnyDesk"

# Chiude AnyDesk se è rimasto appeso (evita popup di installazione)
Stop-Process -Name "AnyDesk*" -Force -ErrorAction SilentlyContinue

if (Test-Path $AppDataPath) {
    Remove-Item -Path "$AppDataPath\service.conf" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$AppDataPath\system.conf" -Force -ErrorAction SilentlyContinue
}

if (Test-Path $LocalPath) {
    Remove-Item -Path $LocalPath -Recurse -Force -ErrorAction SilentlyContinue
}

# 2. Avvio di AnyDesk (Percorso dell'eseguibile originale)
# Cambia questo percorso con quello dove tieni il vero AnyDesk.exe
$AnyDeskExe = "F:\app-Ryzen\AnyDesk.exe" 
Start-Process -FilePath $AnyDeskExe