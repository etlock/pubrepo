Set-NetConnectionProfile -NetworkCategory Private
Enable-PSRemoting -Force
Get-NetFirewallRule -Name 'WINRM*' | Select-Object Name
Write-Host "Delete any existing WinRM listeners"
winrm delete winrm/config/listener?Address=*+Transport=HTTP  2>$Null
winrm delete winrm/config/listener?Address=*+Transport=HTTPS 2>$Null

Write-Host "Create a new WinRM listener and configure"
winrm create winrm/config/listener?Address=*+Transport=HTTP
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{MaxConcurrentOperationsPerUser="12000"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

Write-Host "Configure UAC to allow privilege elevation in remote shells"
$Key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$Setting = 'LocalAccountTokenFilterPolicy'
Set-ItemProperty -Path $Key -Name $Setting -Value 1 -Force

Write-Host "turn off PowerShell execution policy restrictions"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

Write-Host "Configure and restart the WinRM Service; Enable the required firewall exception"
Stop-Service -Name WinRM
Set-Service -Name WinRM -StartupType Automatic
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new action=allow localip=any remoteip=any
Start-Service -Name WinRM

Set-ExecutionPolicy Bypass -NoProfile -NonInteractive -Scope Process -Force [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Set-WinUserLanguageList -LanguageList pt-pt -Force
choco install googlechrome -y --ignore-checksums
choco install mremoteng -y
choco install git.install -y
choco install vscode -y
choco install azure-data-studio -y
choco install visualstudio2019community -y
choco install win-rdm docker-desktop -y