import{store}from"./store";
export function memoryContext(){return{tasks:store.tasks().filter(x=>!x.done).slice(0,10),ideas:store.ideas().slice(0,10)}}
