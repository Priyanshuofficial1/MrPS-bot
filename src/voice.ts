export interface STT { listen(): AsyncGenerator<string>; stop(): Promise<void> }
export interface TTS { speak(text: string): Promise<void> }
export interface WakeWord { start(cb: () => void): Promise<void>; stop(): Promise<void> }

/** Server-side fallback. Browser voice is implemented in public/index.html so no cloud key is required. */
export class ConsoleTTS implements TTS {
  async speak(text: string) { console.log("MrPS:", text) }
}

export const VOICE_CAPABILITIES = {
  provider: "browser-native",
  speechRecognition: "Web Speech API",
  speechSynthesis: "Web Speech API",
  wakeWord: "client-side phrase detection",
  cloudRequired: false,
}
