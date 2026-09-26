@echo off
schtasks /Create /TN "MrPS Assistant" /TR "bun run C:\PATH\TO\MrPS-bot\src\server.ts" /SC ONLOGON /F
echo Edit the path in this file before running.
