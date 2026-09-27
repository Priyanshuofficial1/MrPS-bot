# Voice mode
MrPS uses the browser's native Web Speech API for the first voice milestone: no paid voice API and no cloud voice credential. Chrome/Edge provides speech recognition and speech synthesis. The UI runs continuous recognition while the mic is enabled, detects the wake phrase `MrPS`, executes the deterministic local router, and reads safe responses aloud.

This is intentionally a provider interface: a future local Whisper/Vosk/Piper stack can replace browser speech without changing the assistant core.

For true always-on PC startup behavior, install `scripts/install-startup.ps1` as a Windows logon task. The browser dashboard is then opened automatically.
