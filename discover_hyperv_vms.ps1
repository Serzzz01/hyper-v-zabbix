$runningVMs = Get-VM | Where-Object { $_.State -eq 'Running' } | Select-Object -ExpandProperty Name

$discovery = @()

foreach ($vm in $runningVMs) {
    $discovery += @{ "{#VM.NAME}" = $vm }
}

$discovery | ConvertTo-Json

