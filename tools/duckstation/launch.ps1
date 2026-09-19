[CmdletBinding()]
param([switch]$FastBoot,[string]$StateFile,[string]$Disc='C:\Temp\nfs4_test\nfs4_baseline.cue')
# NFS4 copy of the PSX-Dynamic-Decomp launcher (methodology preserved, paths/port swapped).
# Own runtime copy, own GDB port 2350 -- never the FF endpoint 2348 or the TM2 endpoint 2349.
$ErrorActionPreference='Stop'
$ProjectRoot=Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$Runtime=Join-Path $PSScriptRoot 'api-runtime'
$Executable=Join-Path $Runtime 'duckstation-qt-x64-ReleaseLTCG.exe'
$Port=2350
if (Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction SilentlyContinue) { throw "GDB port $Port is already in use; refusing to connect to another project." }
$Ini=Join-Path $Runtime 'settings.ini'
$Text=Get-Content $Ini -Raw
$Text=$Text -replace 'EmulationSpeed = [^\r\n]+','EmulationSpeed = 0'
$Text=$Text -replace 'OutputMuted = [^\r\n]+','OutputMuted = true'
$Text=$Text -replace 'StartPaused = [^\r\n]+','StartPaused = true'
$Text=$Text -replace '(?m)^VSync = [^\r\n]+','VSync = false'
$Text=$Text -replace 'GDBServerPort = [^\r\n]+',"GDBServerPort = $Port"
Set-Content $Ini $Text -Encoding utf8
$Arguments=@('-batch')
if ($FastBoot) { $Arguments+='-fastboot' }
if ($StateFile) {
 $StateFile=(Resolve-Path -LiteralPath $StateFile -ErrorAction Stop).Path
 $Arguments+='-statefile'
 $Arguments+='"'+$StateFile+'"'
}
$Arguments+='"'+$Disc+'"'
$Process=Start-Process -FilePath $Executable -ArgumentList $Arguments -WorkingDirectory $Runtime -WindowStyle Hidden -PassThru
$Deadline=(Get-Date).AddSeconds(30)
do {
 if ($Process.HasExited) { throw "DuckStation exited with code $($Process.ExitCode)" }
 $Listeners=@(Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction SilentlyContinue)
 if ($Listeners.Count) { break }
 Start-Sleep -Milliseconds 200
} while ((Get-Date) -lt $Deadline)
if (-not $Listeners.Count) { Stop-Process -Id $Process.Id; throw 'DuckStation GDB startup timed out' }
if (@($Listeners | Where-Object {$_.OwningProcess -ne $Process.Id -or $_.LocalAddress -notin @('127.0.0.1','::1')}).Count) { Stop-Process -Id $Process.Id; throw 'Unexpected GDB owner or non-loopback listener' }
$StatusDir=Join-Path $ProjectRoot 'status\runtime'
New-Item -ItemType Directory -Force $StatusDir | Out-Null
$Record=@{pid=$Process.Id;executable=$Executable;port=$Port;listeners=@($Listeners | Select-Object LocalAddress,LocalPort,OwningProcess);started=(Get-Date).ToString('o')}
$Record | ConvertTo-Json -Depth 4 | Set-Content -Encoding utf8 (Join-Path $StatusDir 'duckstation-process.json')
$Record | ConvertTo-Json -Depth 4
