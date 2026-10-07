[CmdletBinding()]
param(
    [string]$RetailCue = 'C:\Temp\nfs4iso\NFS4.cue',
    [string]$CandidateCue = 'C:\Temp\nfs4iso\NFS4.cue',
    [switch]$FastBoot
)

$ErrorActionPreference = 'Stop'
$PairRoot = 'C:\Temp\nfs4-syslib-pair'
$Specs = @(
    @{ Role='retail'; Runtime=(Join-Path $PairRoot 'retail'); Port=2350; Cue=$RetailCue },
    @{ Role='candidate'; Runtime=(Join-Path $PairRoot 'candidate'); Port=2351; Cue=$CandidateCue }
)

function Get-CueImage([string]$Cue) {
    $line = Get-Content -LiteralPath $Cue | Where-Object { $_ -match '^\s*FILE\s+"([^"]+)"' } | Select-Object -First 1
    if (-not $line -or $line -notmatch '^\s*FILE\s+"([^"]+)"') { throw "No FILE entry in $Cue" }
    return (Resolve-Path -LiteralPath (Join-Path (Split-Path $Cue) $Matches[1])).Path
}

$started = @()
try {
    foreach ($spec in $Specs) {
        if (Get-NetTCPConnection -State Listen -LocalPort $spec.Port -ErrorAction SilentlyContinue) {
            throw "Port $($spec.Port) is already in use"
        }
        $exe = Join-Path $spec.Runtime 'duckstation-qt-x64-ReleaseLTCG.exe'
        $ini = Join-Path $spec.Runtime 'settings.ini'
        $bios = Join-Path $spec.Runtime 'bios\scph5502.bin'
        foreach ($path in @($exe,$ini,$bios,$spec.Cue)) {
            if (-not (Test-Path -LiteralPath $path)) { throw "Missing $path" }
        }
        $image = Get-CueImage $spec.Cue
        $args = @('-batch')
        if ($FastBoot) { $args += '-fastboot' }
        $args += ('"' + (Resolve-Path -LiteralPath $spec.Cue).Path + '"')
        $process = Start-Process -FilePath $exe -ArgumentList $args -WorkingDirectory $spec.Runtime -WindowStyle Hidden -PassThru
        $started += $process
        $deadline = (Get-Date).AddSeconds(30)
        do {
            if ($process.HasExited) { throw "$($spec.Role) DuckStation exited: $($process.ExitCode)" }
            $listeners = @(Get-NetTCPConnection -State Listen -LocalPort $spec.Port -ErrorAction SilentlyContinue)
            if ($listeners.Count) { break }
            Start-Sleep -Milliseconds 200
        } while ((Get-Date) -lt $deadline)
        if (-not $listeners.Count) { throw "$($spec.Role) GDB startup timeout" }
        if (@($listeners | Where-Object { $_.OwningProcess -ne $process.Id -or $_.LocalAddress -notin @('127.0.0.1','::1') }).Count) {
            throw "$($spec.Role) has an unexpected listener owner/address"
        }
        $record = [ordered]@{
            schema='nfs4-syslib-runtime-v1'; role=$spec.Role; pid=$process.Id; port=$spec.Port
            executable=$exe; runtime_sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $exe).Hash.ToLower()
            settings=$ini; settings_sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $ini).Hash.ToLower()
            bios=$bios; bios_sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $bios).Hash.ToLower()
            cue=(Resolve-Path -LiteralPath $spec.Cue).Path
            cue_sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $spec.Cue).Hash.ToLower()
            image=$image; image_sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $image).Hash.ToLower()
            started=(Get-Date).ToString('o')
            listeners=@($listeners | Select-Object LocalAddress,LocalPort,OwningProcess)
        }
        $recordPath = Join-Path $PairRoot ($spec.Role + '-process.json')
        $record | ConvertTo-Json -Depth 5 | Set-Content -Encoding utf8 -LiteralPath $recordPath
        Write-Output $record
    }
} catch {
    foreach ($process in $started) { Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue }
    throw
}

