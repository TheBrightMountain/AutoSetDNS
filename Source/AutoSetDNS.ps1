$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName) }
$logPath = Join-Path $basePath "AutoSetDNS.log"
$configPath = Join-Path $basePath "AutoSetDNS.config.json"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Use Add-Content instead of Out-File for proper encoding
"[$timestamp] [AutoSetDNS] Executing..." | Add-Content -Path $logPath -Encoding UTF8

if (!(Test-Path $configPath)) {
    "[$timestamp] [AutoSetDNS] Config not found at: $configPath" | Add-Content -Path $logPath -Encoding UTF8
    exit 1
}

$config = Get-Content $configPath | ConvertFrom-Json
$dns1 = $config.dns1
$dns2 = $config.dns2
$excludedKeywords = $config.excludedKeywords

$ErrorActionPreference = "Stop"

try {
    $upAdapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    "[$timestamp] [AutoSetDNS] Found $($upAdapters.Count) adapter(s)." | Add-Content -Path $logPath -Encoding UTF8

    $filteredAdapters = $upAdapters | Where-Object {
        $desc = $_.InterfaceDescription.ToLower()
        -not ($excludedKeywords | Where-Object { $desc -like "*$_*" })
    }

    if ($filteredAdapters.Count -eq 0) {
        "[$timestamp] [AutoSetDNS] No matching adapters found." | Add-Content -Path $logPath -Encoding UTF8
    }

    foreach ($adapter in $filteredAdapters) {
        try {
            Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ($dns1, $dns2)
            "[$timestamp] [AutoSetDNS] DNS set for $($adapter.Name)" | Add-Content -Path $logPath -Encoding UTF8
        } catch {
            "[$timestamp] [AutoSetDNS] Failed on $($adapter.Name): $_" | Add-Content -Path $logPath -Encoding UTF8
        }
    }
} catch {
    "[$timestamp] [AutoSetDNS] General error: $_" | Add-Content -Path $logPath -Encoding UTF8
}
