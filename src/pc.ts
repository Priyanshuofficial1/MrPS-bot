import { spawn } from "node:child_process";
import { platform } from "node:os";

export type PCAction = "open" | "status" | "clipboard" | "shell";
export interface PCResult { ok:boolean; action:PCAction; output?:string; error?:string }

function run(cmd:string,args:string[],timeout=10000):Promise<PCResult>{return new Promise(resolve=>{const p=spawn(cmd,args,{stdio:["ignore","pipe","pipe"]});let out="",err="";const timer=setTimeout(()=>{p.kill();resolve({ok:false,action:"shell",error:"timeout"})},timeout);p.stdout.on("data",d=>out+=d);p.stderr.on("data",d=>err+=d);p.on("error",e=>{clearTimeout(timer);resolve({ok:false,action:"shell",error:e.message})});p.on("close",code=>{clearTimeout(timer);resolve({ok:code===0,action:"shell",output:out.trim(),error:err.trim()||undefined})})})}

export async function pcOpen(target:string):Promise<PCResult>{
 const url=/^(https?:\/\/|www\.)/i.test(target)?(target.startsWith("www.")?"https://"+target:target):null;
 if(platform()==="win32") return {...await run("cmd.exe",["/c","start","",url||target]),action:"open"};
 if(url) return {...await run("xdg-open",[url]),action:"open"};
 // WSL: delegate Windows app/file opening through explorer.exe when available.
 return {...await run("explorer.exe",[target]),action:"open"};
}

export async function pcStatus():Promise<PCResult>{
 if(platform()==="win32") return {...await run("powershell.exe",["-NoProfile","-Command","$c=Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average; $m=Get-CimInstance Win32_OperatingSystem; \"CPU=$([math]::Round($c.Average,1))% RAM=$([math]::Round((1-($m.FreePhysicalMemory/$m.TotalVisibleMemorySize))*100,1))%\""],5000),action:"status"};
 return {...await run("bash",["-lc","printf 'CPU=%s\\n' \"$(awk '{u=$2+$4; t=$2+$4+$5} END{printf \\\"%.1f%%\\\",100*u/t}' /proc/stat)\"; free -h | awk '/Mem:/{print \\\"RAM=\\\"$3\\\"/\\\"$2}'"],5000),action:"status"};
}
