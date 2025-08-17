param (
    [string]$themeJson
)

# Parse theme
$theme = $themeJson | ConvertFrom-Json
$background = $theme.background_image

if ($background) {
    try {
        # SPI_SETDESKWALLPAPER = 20
        $SPI_SETDESKWALLPAPER = 20
        $UpdateIniFile = 0x01
        $SendWinIniChange = 0x02

        Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", SetLastError = true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

        [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $background, $UpdateIniFile -bor $SendWinIniChange) | Out-Null
    } catch {
        Write-Host "[!] Failed to set wallpaper: $_"
        exit 1
    }
} else {
    Write-Host "[!] No background_image defined in theme"
}
