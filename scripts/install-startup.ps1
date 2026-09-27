# Run this ONCE from an elevated PowerShell prompt after replacing $Repo.
$Repo = "$HOME\MrPS-bot"
$Distro = "kali-linux"
$TaskName = "MrPS Assistant"
$Command = "wsl.exe -d $Distro bash -lc 'export PATH=\"$HOME/.bun/bin:$PATH\"; cd /home/priyanshu/MrPS-bot; nohup bun run start >/tmp/mrps-bot.log 2>&1 &'"
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `"$Command; Start-Sleep -Seconds 3; Start-Process http://127.0.0.1:8787`""
$Trigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Description "Start MrPS personal assistant at Windows logon" -Force
Write-Host "Installed $TaskName."
