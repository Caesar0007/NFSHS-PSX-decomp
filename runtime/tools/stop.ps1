$ErrorActionPreference='Stop'
$RuntimeRoot=Split-Path -Parent $PSScriptRoot
$File=Join-Path $RuntimeRoot 'status\duckstation-process.json'
if(-not(Test-Path -LiteralPath $File)){return}
$Record=Get-Content -LiteralPath $File -Raw | ConvertFrom-Json
$Process=Get-CimInstance Win32_Process -Filter "ProcessId = $($Record.pid)"
if($Process -and $Process.ExecutablePath -eq $Record.executable) { Stop-Process -Id $Record.pid }
elseif($Process){throw 'PID belongs to a different executable; refusing to stop it'}
