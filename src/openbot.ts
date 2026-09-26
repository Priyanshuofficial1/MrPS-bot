import{existsSync}from"node:fs";export function openBotStatus(path=process.env.MRPS_OPENBOT_PATH||"/home/priyanshu/mrps-openbot"){return{configured:path,available:existsSync(path),mode:"adapter"}}
