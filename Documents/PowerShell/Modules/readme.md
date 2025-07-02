## enviorment
enviorment variables (user):  
`PSModulePath` = `mydocuments/powershell`  

## structure

```
mydocuments/powershell
│   modules
│   │   My.Module
│   │   │   My-Command.ps1
│   │   └   My.Module.psm1
│   └── My.Module2
│   │   │   My-OtherCommand.ps1
│   │   └── My.Module2.psm1
│   └── New-QuickManifest.ps1
└── profile.ps1
```

### My.Module.psm1
```pwsh
. $psScriptRoot\My-Command.ps1

Export-ModuleMember -Function My-Command
```

### My.Module2.psm1
```pwsh
. $psScriptRoot\My-OtherCommand.ps1

Export-ModuleMember -Function My-OtherCommand
```
### New-QuickManifest.ps1
```pwsh
param (
    [string]
    $name,

    [string]
    $description,

    [string[]]
    $functions
)

New-ModuleManifest -Path "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Modules\$($name)\$($name).psd1" `
    -Author "Alex ter Horst" `
    -Description $description `
    -Guid $(New-Guid) `
    -PowerShellVersion $($pSVersionTable.PSVersion) `
    -RootModule ".\$($name).psm1" `
    -FunctionsToExport $functions
```
## register module
```pwsh
# location: \PowerShell\Modules\$name
..\New-QuickManifest.ps1 -name $name -description "test test test" -functions "Test-Test","Test-Test2"