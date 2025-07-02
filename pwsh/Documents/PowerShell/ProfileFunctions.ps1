
# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

function Get-Settings
{
    if (Test-Path $MyPsSettingsPath)
    {
        $MyPSSettings = Get-Content -Raw -Path $MyPsSettingsPath | ConvertFrom-Json
    } else
    {
        $MyPSSettings = @{ theme = $null }
        $MyPSSettings | ConvertTo-Json | Out-File -FilePath $MyPsSettingsPath
    }
    return $MyPSSettings
}

function fzfjq
{
    param(
        [Parameter(ValueFromPipeline=$true)]
        $piped
    )

    Write-Output '' | `
            fzf --disabled `
            --preview-window="up:90%" `
            --print-query `
            --query="." `
            --preview "echo '$piped' | jq {q} | bat --color=always -l json --style=plain"
}

function Edit
{
    [cmdletbinding()]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "The top level path to search"
        )]
        [ValidateScript({
                if (Test-Path $_)
                {
                    $True
                } else
                {
                    Throw "Cannot validate path $_"
                }
            })]
        [string]$Path = "."
    )
    nvim $Path
}

function Open-Dir
{
    [cmdletbinding()]
    Param(
        [Parameter(
            Position = 0,
            HelpMessage = "The top level path to search"
        )]
        [ValidateScript({
                if (Test-Path $_)
                {
                    $True
                } else
                {
                    Throw "Cannot validate path $_"
                }
            })]
        [string]$Path = "."
    )
    explorer $Path
}

function Up-Dir
{
    Set-Location ..
}
function List-Dotfiles
{
    Get-ChildItem -Filter ".*"
}
function Reload
{
    . $profile.CurrentUserAllHosts | Invoke-Expression 
}
function FuzzyFindOpen
{
    fzf | xargs nvim 
}
