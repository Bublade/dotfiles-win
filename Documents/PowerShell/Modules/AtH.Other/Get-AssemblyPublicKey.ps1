function Get-AssemblyPublicKey {
    param (
        [ValidateScript({
                if ( -Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "File or folder does not exist"
                }
                return $true
            })]
        [System.IO.FileInfo]
        $assemblypath
    )
    $path = ([System.IO.Path]::GetFullPath($assemblypath, $PWD))
    $assembly = [System.Reflection.Assembly]::Load([IO.File]::ReadAllBytes($path))
    (($assembly.GetName().GetPublicKey()|ForEach-Object ToString X2) -join '')
}

