[CmdletBinding()]
param([switch]$FastBoot,[string]$StateFile,[string]$Disc='C:\Temp\_from_github\NFS4.CCD',[string]$Exe)
$ErrorActionPreference='Stop'
# nfs4-decomp runtime lane: patched DuckStation (GDB full save/load state), port 2350.
$RuntimeRoot=Split-Path -Parent $PSScriptRoot          # .../runtime
$Runtime=Join-Path $RuntimeRoot 'duckstation'
$Executable=Join-Path $Runtime 'duckstation-qt-x64-ReleaseLTCG.exe'
if ($Exe) { $Disc=(Resolve-Path -LiteralPath $Exe).Path }   # boot a PS-X EXE/CPE directly
$Port=2350
if (Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction SilentlyContinue) { throw "GDB port $Port is already in use; refusing to connect to another project." }
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
$Record=@{pid=$Process.Id;executable=$Executable;port=$Port;disc=$Disc;listeners=@($Listeners | Select-Object LocalAddress,LocalPort,OwningProcess);started=(Get-Date).ToString('o')}
$Record | ConvertTo-Json -Depth 4 | Set-Content -Encoding utf8 (Join-Path $RuntimeRoot 'status\duckstation-process.json')
$Record | ConvertTo-Json -Depth 4
