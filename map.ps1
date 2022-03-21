cmd.exe /C "cmdkey /add:`"obprdstgvmcvc.file.core.windows.net`" /user:`"localhost\obprdstgvmcvc`" /pass:`"lU9PSIGwcfYk5iQ65jqBnUKvlvyb7guUolCkfRdgSpVWLzq+FT7uSvgF1QdXNHqcL9uKgKwTttjPrNlACHpHog==`""
New-PSDrive -Name F -PSProvider FileSystem -Root "\\obprdstgvmcvc.file.core.windows.net\cvcfiles" -Persist
