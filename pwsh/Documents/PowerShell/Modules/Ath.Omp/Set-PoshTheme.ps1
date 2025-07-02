
function Set-PoshTheme {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $theme,

        [switch]
        $refresh

    )

    if ($theme -match "omp\.json$" -and (Test-Path -Path $theme)) {
        $MyPSSettings.theme = $theme;
    }
    else {
        $poshThemsPath = "$($env:LOCALAPPDATA)\Programs\oh-my-posh\themes"
        $themePath = "$($poshThemsPath)\$($theme).omp.json"
        if (Test-Path -Path $themePath) {
            $MyPSSettings.theme = $themePath;
            Write-Host "Theme set"
        }
        else {
            Write-Host "Theme '$($theme)' does not exist in '$($poshThemsPath)'!"
        }
    }

    $MyPSSettings | ConvertTo-Json | Out-File -FilePath $PSSettingsPath

    if ($refresh) {
        oh-my-posh init pwsh --config $MyPSSettings.theme | Invoke-Expression
    }
}
