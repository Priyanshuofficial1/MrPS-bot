param([string]$ServerUrl="http://127.0.0.1:8787",[string]$WakeWord="MrPS",[switch]$Once)
$ErrorActionPreference='Stop'
try { Add-Type -AssemblyName System.Speech } catch { Write-Error 'System.Speech is unavailable. Install/enable Windows Speech Recognition/.NET desktop components.'; exit 2 }
$recognizer=New-Object System.Speech.Recognition.SpeechRecognitionEngine
$synth=New-Object System.Speech.Synthesis.SpeechSynthesizer
try{$recognizer.SetInputToDefaultAudioDevice()}catch{Write-Error 'No usable default microphone was found.';exit 3}
$grammar=New-Object System.Speech.Recognition.DictationGrammar;$recognizer.LoadGrammar($grammar)
function Speak([string]$Text){if($Text){Write-Host "MrPS: $Text";try{$synth.SpeakAsync($Text)|Out-Null}catch{}}}
function Send-Command([string]$Command){if([string]::IsNullOrWhiteSpace($Command)){return};try{$body=@{text=$Command}|ConvertTo-Json;$r=Invoke-RestMethod -Uri "$ServerUrl/api/command" -Method Post -ContentType 'application/json' -Body $body -TimeoutSec 20;if($r.result.message){Speak([string]$r.result.message)}elseif($r.result.output){Speak([string]$r.result.output)}elseif($r.result.time){Speak("It is $($r.result.time)")}elseif($r.result.blocked){Speak('That action is blocked for safety.')}elseif($r.result.needsConfirmation){Speak('That action needs your confirmation in the MrPS control panel.')}else{Speak('Done, Boss.')}}catch{Speak("MrPS server is unavailable. $($_.Exception.Message)")}}
$script:state='waiting'
$handler={param($sender,$e);$heard=$e.Result.Text;Write-Host "Heard: $heard";$idx=$heard.IndexOf($WakeWord,[StringComparison]::OrdinalIgnoreCase);if($idx -ge 0){$cmd=$heard.Substring($idx+$WakeWord.Length).Trim(' ',',',':',';','!','.');if($cmd){Send-Command $cmd}else{$script:state='armed';Speak('Yes, Boss?')}}elseif($script:state -eq 'armed'){$script:state='waiting';Send-Command $heard}}
$recognizer.add_SpeechRecognized($handler)
$recognizer.RecognizeAsync([System.Speech.Recognition.RecognizeMode]::Multiple)
Speak "Voice control online. Say $WakeWord."
try{do{Start-Sleep -Milliseconds 250}while(-not $Once)}finally{$recognizer.RecognizeAsyncCancel();$recognizer.Dispose();$synth.Dispose()}
