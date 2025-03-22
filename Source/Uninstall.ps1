# Check if the script is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show(
        "This script must be run as an administrator!",
        "Administrator Privileges Required",
        [System.Windows.MessageBoxButton]::OK,
        [System.Windows.MessageBoxImage]::Error
    )
    exit 1
}

$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName) }
$logPath = Join-Path $basePath "AutoSetDNS.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

"[$timestamp] [Uninstaller] Uninstalling..." | Add-Content -Path $logPath -Encoding UTF8

try {
    $taskName = "AutoSetDNS"
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop
        "[$timestamp] [Uninstaller] Task '$taskName' removed successfully." | Add-Content -Path $logPath -Encoding UTF8

        Add-Type -AssemblyName PresentationFramework
        [System.Windows.MessageBox]::Show(
            "The task '$taskName' was removed successfully.",
            "Uninstallation Successful",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information
        )
    }
    else {
        "[$timestamp] [Uninstaller] Task '$taskName' was not found. It may have already been removed." | Add-Content -Path $logPath -Encoding UTF8

        Add-Type -AssemblyName PresentationFramework
        [System.Windows.MessageBox]::Show(
            "The task '$taskName' was not found. It may have already been removed.",
            "Task Not Found",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Warning
        )
    }
}
catch {
    "[$timestamp] [Uninstaller] ERROR: $_" | Add-Content -Path $logPath -Encoding UTF8

    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show(
        "An error occurred during uninstallation: $_",
        "Uninstallation Error",
        [System.Windows.MessageBoxButton]::OK,
        [System.Windows.MessageBoxImage]::Error
    )
}