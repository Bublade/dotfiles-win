param (
    [string]
    $name,

    [string]
    $description,

    [string[]]
    $functions,

    [string]
    $path = "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Modules\$($name)\$($name).psd1",

    [string]
    $rootmodule = ".\$($name).psm1",

    [string]
    $author = "Alex ter Horst"
)

New-ModuleManifest -Path $path `
    -Author $author `
    -Description $description `
    -Guid $(New-Guid) `
    -PowerShellVersion $($PSVersionTable.PSVersion) `
    -RootModule $rootmodule `
    -FunctionsToExport $functions
