$ErrorActionPreference='Continue';$ok=$true
try{Add-Type -AssemblyName System.Speech;Write-Host '[PASS] System.Speech'}catch{Write-Host '[FAIL] System.Speech';$ok=$false}
try{$r=New-Object System.Speech.Recognition.SpeechRecognitionEngine;$r.SetInputToDefaultAudioDevice();Write-Host '[PASS] Default microphone';$r.Dispose()}catch{Write-Host '[WARN] Default microphone unavailable:' $_.Exception.Message}
try{$s=New-Object System.Speech.Synthesis.SpeechSynthesizer;$s.Speak('MrPS voice test');$s.Dispose();Write-Host '[PASS] TTS'}catch{Write-Host '[FAIL] TTS';$ok=$false}
try{$h=Invoke-RestMethod 'http://127.0.0.1:8787/api/health' -TimeoutSec 3;if($h.ok){Write-Host '[PASS] MrPS server'}else{$ok=$false}}catch{Write-Host '[FAIL] MrPS server';$ok=$false}
if(-not $ok){exit 1};Write-Host 'Voice smoke test complete.'
