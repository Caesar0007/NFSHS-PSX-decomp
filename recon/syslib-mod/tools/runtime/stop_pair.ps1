$ErrorActionPreference = 'Stop'
$PairRoot = 'C:\Temp\nfs4-syslib-pair'
foreach ($role in @('retail','candidate')) {
    $path = Join-Path $PairRoot ($role + '-process.json')
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $record = Get-Content -Raw -LiteralPath $path | ConvertFrom-Json
    $process = Get-Process -Id $record.pid -ErrorAction SilentlyContinue
    if ($process -and $process.Path -eq $record.executable) {
        Stop-Process -Id $record.pid -Force
        Wait-Process -Id $record.pid -Timeout 10 -ErrorAction SilentlyContinue
    }
}
