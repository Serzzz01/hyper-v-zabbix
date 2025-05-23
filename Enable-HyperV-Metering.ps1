Get-VM | Where-Object { -not $_.ResourceMeteringEnabled } | ForEach-Object {
    Enable-VMResourceMetering -VMName $_.Name
    Write-Output "Enabled resource metering for VM: $($_.Name)"
}