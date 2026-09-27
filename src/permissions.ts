import type { Permission } from "./types";
const dangerous=/\b(delete|format|wipe|shutdown|restart|kill|terminate|uninstall|credential|password|token|secret|disable\s+(?:firewall|security|defender))\b/i;
const elevated=/\b(install|sudo|powershell|registry|service|process|shell|command|script|run)\b/i;
export function permissionFor(text:string):Permission { if(dangerous.test(text)) return "restricted"; if(elevated.test(text)) return "confirm"; return "auto"; }
