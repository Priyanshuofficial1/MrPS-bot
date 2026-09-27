param([string]$InstallDir="$env:LOCALAPPDATA\MrPS-bot")
$startup="$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\MrPS-Voice.cmd"
Remove-Item $startup -Force -ErrorAction SilentlyContinue
Remove-Item $InstallDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host 'MrPS voice startup removed.'
