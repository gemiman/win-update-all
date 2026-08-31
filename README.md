~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

```ps1
(&mise activate pwsh) | Out-String | Invoke-Expression
# ===== update-rust global command =====
function update-rust {
    & pwsh -NoProfile -ExecutionPolicy Bypass -File "C:\Users\gemim\projects\rust\scripts\update-rust.ps1" @args
}

function update-sys-all {
    & pwsh -NoProfile -ExecutionPolicy Bypass -File "C:\Users\gemim\projects\rust\scripts\sysup-all.ps1" @args
}



```
