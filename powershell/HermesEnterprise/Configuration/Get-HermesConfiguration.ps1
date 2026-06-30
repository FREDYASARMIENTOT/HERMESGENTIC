function Get-HermesConfiguration {

    param(
        [string]$File = "settings.json"
    )

    $Root = Split-Path $PSScriptRoot -Parent

    $Config = Join-Path $Root "..\..\config\$File"

    $Config = Resolve-Path $Config

    Get-Content $Config |
        ConvertFrom-Json

}
