# MrPS real Windows voice control
MrPS-Voice.ps1 is a local Windows companion using .NET System.Speech for microphone recognition and SpeechSynthesizer for TTS. No cloud STT/TTS is used.
1. Start MrPS and confirm http://127.0.0.1:8787/api/health.
2. Run Set-ExecutionPolicy -Scope CurrentUser RemoteSigned if needed.
3. Run scripts/windows-voice/smoke-test.ps1.
4. Run scripts/windows-voice/MrPS-Voice.ps1.
5. Say MrPS, then the command, or say MrPS, what time is it.
6. Run scripts/windows-voice/install.ps1 for Windows-login startup; uninstall.ps1 removes it.
If System.Speech/microphone is unavailable, the companion exits with an explicit diagnostic. Browser voice remains a fallback. Voice never bypasses MrPS permission checks.
