param([string]$InstallDir="$env:LOCALAPPDATA\MrPS-bot")
$ErrorActionPreference='Stop'
New-Item -ItemType Directory -Force -Path $InstallDir|Out-Null
Copy-Item "$PSScriptRoot\MrPS-Voice.ps1" "$InstallDir\MrPS-Voice.ps1" -Force
$startup="$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
New-Item -ItemType Directory -Force -Path $startup|Out-Null
$cmd='powershell.exe -NoProfile -ExecutionPolicy Bypass -File "'+$InstallDir+'\MrPS-Voice.ps1"'
Set-Content "$startup\MrPS-Voice.cmd" -Value @('@echo off',$cmd) -Encoding ASCII
Write-Host "Installed MrPS voice companion: $InstallDir"
