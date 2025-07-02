#Requires -Version 7.0
param (
    [Parameter(Mandatory=$true, Position=1)]
    [string]
    $name
)

wsl -d $name --exec dbus-launch true

