export type Permission="auto"|"confirm"|"restricted";
export type IntentKind="open"|"system"|"time"|"workspace"|"task"|"idea"|"reminder"|"unknown";
export interface Intent{kind:IntentKind;text:string;args:Record<string,string>;permission:Permission;confidence:number}
export interface Task{id:string;title:string;due:number|null;done:boolean;created:number}
