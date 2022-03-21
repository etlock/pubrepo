$connectTestResult = Test-NetConnection -ComputerName obprdstgvmcvc.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"obprdstgvmcvc.file.core.windows.net`" /user:`"localhost\obprdstgvmcvc`" /pass:`"lU9PSIGwcfYk5iQ65jqBnUKvlvyb7guUolCkfRdgSpVWLzq+FT7uSvgF1QdXNHqcL9uKgKwTttjPrNlACHpHog==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\obprdstgvmcvc.file.core.windows.net\cvcfiles" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}
