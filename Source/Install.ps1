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

# Remove any old temp logs
Remove-Item "$env:TEMP\AutoSetDNS-Installer.log" -Force -ErrorAction SilentlyContinue
"[$timestamp] [Installer] Starting install..." | Add-Content -Path $logPath -Encoding UTF8

try {
  $exePath = Join-Path $basePath "AutoSetDNS.exe"
  $taskName = "AutoSetDNS"
  $logName = "Microsoft-Windows-NetworkProfile/Operational"
  $userName = "$env:UserDomain\$env:UserName"

  if (!(Test-Path $exePath)) {
    "[$timestamp] [Installer] AutoSetDNS.exe not found." | Add-Content -Path $logPath -Encoding UTF8
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show(
      "AutoSetDNS.exe not found. Installation cannot proceed.",
      "Installation Failed",
      [System.Windows.MessageBoxButton]::OK,
      [System.Windows.MessageBoxImage]::Error
    )
    exit 1
  }

  wevtutil set-log $logName /enabled:true

  $xml = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <Triggers>
    <EventTrigger>
      <Subscription><![CDATA[
        <QueryList>
          <Query Id="0" Path="$logName">
            <Select Path="$logName">*[System[EventID=10000]]</Select>
          </Query>
        </QueryList>
      ]]></Subscription>
      <Enabled>true</Enabled>
    </EventTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>$userName</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <StartWhenAvailable>true</StartWhenAvailable>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>true</Hidden>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>$exePath</Command>
    </Exec>
  </Actions>
</Task>
"@

  $xmlPath = "$env:TEMP\AutoSetDNS_Task.xml"
  $xml | Out-File -Encoding Unicode $xmlPath

  schtasks.exe /Create /TN $taskName /XML $xmlPath /F
  Remove-Item $xmlPath -Force

  "[$timestamp] [Installer] Task '$taskName' registered successfully." | Add-Content -Path $logPath -Encoding UTF8

  Add-Type -AssemblyName PresentationFramework
  [System.Windows.MessageBox]::Show(
    "The task '$taskName' was registered successfully.",
    "Installation Successful",
    [System.Windows.MessageBoxButton]::OK,
    [System.Windows.MessageBoxImage]::Information
  )
}
catch {
  "[$timestamp] [Installer] ERROR: $_" | Add-Content -Path $logPath -Encoding UTF8
  Add-Type -AssemblyName PresentationFramework
  [System.Windows.MessageBox]::Show(
    "An error occurred during installation: $_",
    "Installation Error",
    [System.Windows.MessageBoxButton]::OK,
    [System.Windows.MessageBoxImage]::Error
  )
}