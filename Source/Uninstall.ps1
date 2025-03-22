$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName) }
$logPath = Join-Path $basePath "AutoSetDNS.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Remove-Item "$env:TEMP\AutoSetDNS-Installer.log" -Force -ErrorAction SilentlyContinue
"[$timestamp] [Uninstaller] Uninstalling..." | Add-Content -Path $logPath -Encoding UTF8

try {
    $taskName = "AutoSetDNS"
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop
        "[$timestamp] [Uninstaller] Task '$taskName' removed successfully." | Add-Content -Path $logPath -Encoding UTF8
    } else {
        "[$timestamp] [Uninstaller] Task '$taskName' was not found. It may have already been removed." | Add-Content -Path $logPath -Encoding UTF8
    }
} catch {
    "[$timestamp] [Uninstaller] ERROR: $_" | Add-Content -Path $logPath -Encoding UTF8
}
