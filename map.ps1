$username = "localhost\obprdstgvmcvc"
$password = "lU9PSIGwcfYk5iQ65jqBnUKvlvyb7guUolCkfRdgSpVWLzq+FT7uSvgF1QdXNHqcL9uKgKwTttjPrNlACHpHog=="
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
New-PSDrive -Name G -PSProvider FileSystem -Root "\\obprdstgvmcvc.file.core.windows.net\cvcfiles" -Persist -Credential $cred
