$connectTestResult = Test-NetConnection -ComputerName obprdstgtools001.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"obprdstgtools001.file.core.windows.net`" /user:`"localhost\obprdstgtools001`" /pass:`"zRkUbAPBi+uN30jv5tjyylYnYh+S0ufIOW4CLtuLPJ37ENR58UovkMvm8D0a2lU3sGVpaBwPuVtwhgXOZ2FQZg==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\obprdstgtools001.file.core.windows.net\temporary" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}