import { permissionFor } from "./permissions";
import { pcOpen, pcStatus } from "./pc";
export async function executePC(text:string){
 const permission=permissionFor(text); if(permission!=="auto") return {ok:false,permission,message:permission==="restricted"?"That action is blocked for safety.":"Confirmation required before I can do that."};
 let m=text.match(/^(?:open|launch|start)\s+(.+)$/i); if(m) return {...await pcOpen(m[1]),permission};
 if(/\b(system status|pc status|computer status|cpu|memory|ram|battery)\b/i.test(text)) return {...await pcStatus(),permission};
 return null;
}
