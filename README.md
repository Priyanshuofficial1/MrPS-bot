# MrPS-bot
Fast, local-first, voice-ready personal PC assistant for MrPS.

## Run
Install Bun, then run: bun install && bun run start
Open http://127.0.0.1:8787.

## Commands
what time is it; system status; open VS Code; open https://example.com; work on a project path; add task; remind me ... in 10 minutes; save idea.

## Voice
The dashboard now has browser-native voice control: click the mic, say “MrPS”, then speak a command. Chrome/Edge handles STT/TTS without a paid API. See `docs/VOICE.md` and `scripts/install-startup.ps1` for PC-logon startup.

## Architecture
Router -> permission policy -> assistant -> adapters. SQLite stores tasks, ideas and audit records locally. A resident scheduler checks due reminders. The dashboard is served by the same localhost daemon. OpenBot is isolated behind an adapter.

## Security
The server binds to localhost. Destructive/security-sensitive phrases are blocked. Add authentication before exposing it beyond localhost. Keep credentials in .env and never source control them. Audit records stay local.
