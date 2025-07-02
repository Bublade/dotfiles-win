$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
$MyPsSettingsPath = "$($MyDocuments)\PowerShell\ps_settings.json"
$MyPSSettings = $null

Import-module "$($HOME)\Documents\PowerShell\ProfileFunctions.ps1" -Force

function Launch-Ghostty
{
    Start-Job -ScriptBlock {
        wsl -d ubuntu --exec ghostty
    }
}


Import-Module AtH.Other
# Import-Module -Name Terminal-Icons

# Import-Module PSFzf
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# dont like with ohmyposh transient prompt
# Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }


Write-Host -NoNewline -ForegroundColor Green "Loading settings: "
Write-Host -ForegroundColor DarkYellow $($MyPsSettingsPath)
$MyPSSettings = Get-Settings
Write-Host -NoNewline -ForegroundColor Green "Theme: "
Write-Host -ForegroundColor DarkYellow $($MyPSSettings.theme)

Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name fzo -Value FuzzyFindOpen
Set-Alias -Name lg -Value lazygit.exe
Set-Alias -Name ll -Value ls
Set-Alias -Name l. -Value List-Dotfiles
Set-Alias -Name g -Value git
Set-Alias -Name .. -Value Up-Dir
Set-Alias -Name e -Value Edit
Set-Alias -Name o -Value yazi


Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -HistoryNoDuplicates

Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -ScriptBlock { fzf | set-Clipboard }
Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+f' -ScriptBlock { FuzzyFindOpen }
Set-PSReadLineKeyHandler -Chord 'Ctrl+g' -ScriptBlock { lazygit }
Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.Powershell.PSConsoleReadLine]::
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('nvim .')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}


if ($null -eq $MyPSSettings.theme -or $MyPSSettings.theme -eq '')
{
    oh-my-posh init pwsh | Invoke-Expression
} else
{
    oh-my-posh init pwsh --config $MyPSSettings.theme | Invoke-Expression
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
