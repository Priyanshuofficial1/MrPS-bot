import{store}from"./store";
let last=new Set<string>();export function startScheduler(){setInterval(()=>{for(const t of store.due() as any[]){if(!last.has(t.id)){last.add(t.id);console.log("NOTIFICATION:",t.title)}}},5000)}
