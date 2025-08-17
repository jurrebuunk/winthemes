param (
    [string]$themeJson
)

# Parse theme JSON
$theme = $themeJson | ConvertFrom-Json
$NewAccentColor = $theme.accent

if (-not $NewAccentColor) {
    Write-Host "[!] No accent color defined in theme"
    exit 1
}

# Convert hex color (#RRGGBB) to integer for registry
$ColorValue = [System.Convert]::ToInt32($NewAccentColor.Replace("#", ""), 16)

# Registry path for Windows 11 accent
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent"

# Apply accent color
Set-ItemProperty -Path $RegPath -Name "AccentColor" -Value $ColorValue -Type DWord
Set-ItemProperty -Path $RegPath -Name "AccentColorMenu" -Value $ColorValue -Type DWord
