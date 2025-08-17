param (
    [string]$themeJson
)

# Convert JSON string to object
$theme = $themeJson | ConvertFrom-Json
$mode = $theme.mode

# Registry keys for dark/light mode
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

if ($mode -eq "dark") {
    Set-ItemProperty -Path $regPath -Name "AppsUseLightTheme" -Value 0
    Set-ItemProperty -Path $regPath -Name "SystemUsesLightTheme" -Value 0
} elseif ($mode -eq "light") {
    Set-ItemProperty -Path $regPath -Name "AppsUseLightTheme" -Value 1
    Set-ItemProperty -Path $regPath -Name "SystemUsesLightTheme" -Value 1
} else {
    Write-Host "Unknown mode: $mode"
    exit 1
}
