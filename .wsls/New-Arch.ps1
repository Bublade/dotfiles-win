#Requires -Version 7.0
param (
    [Parameter(Mandatory=$true, Position=1)]
    [string]
    $name
)

Expand-Archive ./Arch.zip -DestinationPath "./$name"
mv "./$name/Arch.exe" "./$name/$name.exe"

Write-Host -ForegroundColor yellow "
#######################################################
#                      DONT FORGET                    #
# https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/ #
#                      YOU DINGUS                     #
#######################################################
"
